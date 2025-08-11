import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_godmode/core/application/assignment_provider.dart';
import 'package:mafia_godmode/core/application/catalog_providers.dart';
import 'package:mafia_godmode/core/domain/alignment.dart';
import 'package:mafia_godmode/core/domain/game_models.dart';
import 'package:mafia_godmode/core/domain/phase.dart';
import 'package:mafia_godmode/core/domain/role.dart';

final gameStateProvider = StateNotifierProvider<GameController, GameState>((ref) {
  return GameController(ref);
});

class GameController extends StateNotifier<GameState> {
  GameController(this.ref) : super(const GameState());
  final Ref ref;
  Timer? _ticker;

  // Config defaults
  static const nightSeconds = 60;
  static const daySeconds = 180;
  static const voteSeconds = 60;
  static const execSeconds = 20;

  void _log(String type, String text) {
    final ev = GameEvent(at: DateTime.now(), type: type, text: text);
    state = state.copyWith(log: [...state.log, ev]);
  }

  void startFromAssignments() {
    final names = ref.read(playerNamesProvider);
    final assignments = ref.read(assignmentsProvider); // name -> Role
    if (names.isEmpty || assignments.isEmpty) return;

    final players = <Player>[];
    for (final n in names) {
      final role = assignments[n];
      if (role != null) {
        players.add(Player(name: n, roleId: role.id, alive: true));
      }
    }
    _stopTicker();
    state = state.copyWith(
      players: players,
      phase: PhaseType.night,
      cycle: 1,
      secondsLeft: nightSeconds,
      nominations: const [],
      votes: const [],
      pendingNightKill: null,
      doctorProtect: null,
      detectiveTarget: null,
      lastInvestigationResult: null,
      winnerFaction: null,
      isRunning: false,
      log: const [],
    );
    _log('phase', 'Game started • Night 1');
  }

  // Timer controls (unchanged)
  void toggleTimer() { state.isRunning ? _stopTicker() : _startTicker(); state = state.copyWith(isRunning: !state.isRunning); }
  void resetTimer() {
    final sec = switch (state.phase) {
      PhaseType.night => nightSeconds,
      PhaseType.day => daySeconds,
      PhaseType.vote => voteSeconds,
      PhaseType.exec => execSeconds,
      PhaseType.end => 0,
    };
    state = state.copyWith(secondsLeft: sec);
    _log('timer', 'Reset ${state.phase.label} timer');
  }
  void _startTicker() {
    _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.secondsLeft <= 0) { _autoAdvanceOnTimeout(); return; }
      state = state.copyWith(secondsLeft: state.secondsLeft - 1);
    });
  }
  void _stopTicker() { _ticker?.cancel(); _ticker = null; }
  void _autoAdvanceOnTimeout() { _stopTicker(); state = state.copyWith(isRunning: false); _log('timer', 'Auto-advance on timeout'); nextPhase(); }

  // Selections for Night
  void selectNightKill(String? targetName) { state = state.copyWith(pendingNightKill: targetName); _log('select_kill', targetName ?? 'cleared'); }
  void selectDoctorProtect(String? targetName) { state = state.copyWith(doctorProtect: targetName); _log('select_protect', targetName ?? 'cleared'); }
  void selectDetectiveTarget(String? targetName) { state = state.copyWith(detectiveTarget: targetName); _log('select_investigate', targetName ?? 'cleared'); }

  // Phase transitions + resolution
  void nextPhase() {
    switch (state.phase) {
      case PhaseType.night:
        _resolveNight();
        state = state.copyWith(
          phase: PhaseType.day,
          secondsLeft: daySeconds,
          isRunning: false,
        );
        _log('phase', 'Day ${state.cycle}');
        break;
      case PhaseType.day:
        state = state.copyWith(
          phase: PhaseType.vote,
          secondsLeft: voteSeconds,
          isRunning: false,
          nominations: const [],
          votes: const [],
        );
        _log('phase', 'Voting ${state.cycle}');
        break;
      case PhaseType.vote:
        state = state.copyWith(
          phase: PhaseType.exec,
          secondsLeft: execSeconds,
          isRunning: false,
        );
        _log('phase', 'Execution ${state.cycle}');
        break;
      case PhaseType.exec:
        final winner = _checkWin();
        if (winner != null) {
          state = state.copyWith(phase: PhaseType.end, winnerFaction: winner, secondsLeft: 0);
          _log('win', 'Winner: $winner');
        } else {
          state = state.copyWith(
            phase: PhaseType.night,
            secondsLeft: nightSeconds,
            isRunning: false,
            cycle: state.cycle + 1,
          );
          _log('phase', 'Night ${state.cycle}');
        }
        break;
      case PhaseType.end:
        _log('phase', 'Game over');
        break;
    }
  }

  void _resolveNight() {
    // PROTECT → KILL → INVESTIGATE
    final aliveNames = state.players.where((p) => p.alive).map((p) => p.name).toSet();

    // Normalize invalid selections
    final kill = (state.pendingNightKill != null && aliveNames.contains(state.pendingNightKill)) ? state.pendingNightKill : null;
    final protect = (state.doctorProtect != null && aliveNames.contains(state.doctorProtect)) ? state.doctorProtect : null;
    final investigate = (state.detectiveTarget != null && aliveNames.contains(state.detectiveTarget)) ? state.detectiveTarget : null;

    // 1) Doctor protection
    if (protect != null) {
      _log('protect', 'Doctor protects $protect');
    }

    // 2) Mafia kill (cancel if protected)
    if (kill != null) {
      if (protect != null && protect == kill) {
        _log('night_kill_blocked', 'Kill on $kill was prevented');
      } else {
        _kill(kill);
        _log('night_kill', 'Killed $kill');
      }
    } else {
      _log('night', 'No kill selected');
    }

    // 3) Detective investigate (alignment-only result)
    String? investigationResult;
    if (investigate != null) {
      final roles = ref.read(roleCatalogProvider);
      final targetPlayer = state.players.firstWhere((p) => p.name == investigate);
      final role = roles.firstWhere((r) => r.id == targetPlayer.roleId,
          orElse: () => const Role(id: 'villager', name: 'Villager', align: AlignmentType.citizen));
      final isMafia = role.align == AlignmentType.mafia;
      investigationResult = isMafia ? '$investigate is Mafia' : '$investigate is NOT Mafia';
      _log('investigate', investigationResult);
    }

    // Clear selections, preserve last investigation result for morning
    state = state.copyWith(
      pendingNightKill: null,
      doctorProtect: null,
      detectiveTarget: null,
      lastInvestigationResult: investigationResult ?? state.lastInvestigationResult,
    );
  }

  void _kill(String name) {
    final idx = state.players.indexWhere((p) => p.name == name);
    if (idx == -1) return;
    final updated = [...state.players];
    updated[idx] = updated[idx].copyWith(alive: false);
    state = state.copyWith(players: updated);
  }

  // Voting helpers (unchanged from your current pack)
  void nominate(String name) { if (!_isAlive(name) || state.nominations.contains(name)) return; state = state.copyWith(nominations: [...state.nominations, name]); _log('nominate', name); }
  void removeNomination(String name) { state = state.copyWith(nominations: state.nominations.where((n) => n != name).toList()); _log('nominate_remove', name); }
  void castVote({required String voter, required String target}) { final others = state.votes.where((v) => v.voter != voter).toList(); state = state.copyWith(votes: [...others, VoteEntry(voter: voter, target: target)]); _log('vote', '$voter → $target'); }
  String? topVotedTarget() { final tally = <String, int>{}; for (final v in state.votes) { tally[v.target] = (tally[v.target] ?? 0) + 1; } String? best; var bestCount = 0; tally.forEach((n, c) { if (c > bestCount) { best = n; bestCount = c; } }); return best; }
  void executeTopVoted() { final target = topVotedTarget(); if (target != null) { _kill(target); _log('exec', 'Executed $target'); } }

  bool _isAlive(String name) => state.players.any((p) => p.name == name && p.alive);

  String? _checkWin() {
    final roles = ref.read(roleCatalogProvider);
    int mafiaAlive = 0, townAlive = 0, indyAlive = 0;
    for (final p in state.players.where((p) => p.alive)) {
      final role = roles.firstWhere((r) => r.id == p.roleId,
          orElse: () => const Role(id: 'villager', name: 'Villager', align: AlignmentType.citizen));
      switch (role.align) {
        case AlignmentType.mafia: mafiaAlive++; break;
        case AlignmentType.citizen: townAlive++; break;
        case AlignmentType.independent: indyAlive++; break;
      }
    }
    if (mafiaAlive == 0 && indyAlive == 0 && townAlive > 0) return 'Town';
    if (mafiaAlive > 0 && mafiaAlive >= townAlive) return 'Mafia';
    if (indyAlive > 0 && mafiaAlive == 0 && townAlive == 0) return 'Independent';
    return null;
  }

  // Toggle a player's alive/dead state (manual override)
  void toggleAlive(String name) {
    final idx = state.players.indexWhere((p) => p.name == name);
    if (idx == -1) return;
    final updated = [...state.players];
    final newAlive = !updated[idx].alive;
    updated[idx] = updated[idx].copyWith(alive: newAlive);
    state = state.copyWith(players: updated);
    _log('toggle_alive', '$name → ${newAlive ? 'alive' : 'dead'}');
  }
}