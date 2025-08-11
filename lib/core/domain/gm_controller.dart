import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_godmode/core/application/assignment_providers.dart';
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

  // Config defaults (could come from Ruleset later)
  static const nightSeconds = 60;
  static const daySeconds = 180;
  static const voteSeconds = 60;
  static const execSeconds = 20;

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
      winnerFaction: null,
      isRunning: false,
    );
  }

  // Timer controls
  void toggleTimer() {
    if (state.isRunning) {
      _stopTicker();
    } else {
      _startTicker();
    }
    state = state.copyWith(isRunning: !state.isRunning);
  }

  void resetTimer() {
    final sec = switch (state.phase) {
      PhaseType.night => nightSeconds,
      PhaseType.day => daySeconds,
      PhaseType.vote => voteSeconds,
      PhaseType.exec => execSeconds,
      PhaseType.end => 0,
    };
    state = state.copyWith(secondsLeft: sec);
  }

  void _startTicker() {
    _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.secondsLeft <= 0) {
        _autoAdvanceOnTimeout();
        return;
      }
      state = state.copyWith(secondsLeft: state.secondsLeft - 1);
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  void _autoAdvanceOnTimeout() {
    _stopTicker();
    state = state.copyWith(isRunning: false);
    nextPhase();
  }

  // Phase transitions
  void nextPhase() {
    switch (state.phase) {
      case PhaseType.night:
      // Apply pending night kill
        if (state.pendingNightKill != null) {
          _kill(state.pendingNightKill!);
        }
        state = state.copyWith(
          phase: PhaseType.day,
          secondsLeft: daySeconds,
          isRunning: false,
          pendingNightKill: null,
        );
        break;
      case PhaseType.day:
        state = state.copyWith(
          phase: PhaseType.vote,
          secondsLeft: voteSeconds,
          isRunning: false,
          nominations: const [],
          votes: const [],
        );
        break;
      case PhaseType.vote:
        state = state.copyWith(
          phase: PhaseType.exec,
          secondsLeft: execSeconds,
          isRunning: false,
        );
        break;
      case PhaseType.exec:
      // After execution, check win and/or proceed to next night
        final winner = _checkWin();
        if (winner != null) {
          state = state.copyWith(phase: PhaseType.end, winnerFaction: winner, secondsLeft: 0);
        } else {
          state = state.copyWith(
            phase: PhaseType.night,
            secondsLeft: nightSeconds,
            isRunning: false,
            cycle: state.cycle + 1,
          );
        }
        break;
      case PhaseType.end:
        break;
    }
  }

  // Night actions (MVP: one mafia kill)
  void selectNightKill(String? targetName) {
    state = state.copyWith(pendingNightKill: targetName);
  }

  void _kill(String name) {
    final idx = state.players.indexWhere((p) => p.name == name);
    if (idx == -1) return;
    final updated = [...state.players];
    updated[idx] = updated[idx].copyWith(alive: false);
    state = state.copyWith(players: updated);
  }

  // Nominations & Votes
  void nominate(String name) {
    if (!state.players.any((p) => p.name == name && p.alive)) return;
    if (state.nominations.contains(name)) return;
    state = state.copyWith(nominations: [...state.nominations, name]);
  }

  void removeNomination(String name) {
    state = state.copyWith(nominations: state.nominations.where((n) => n != name).toList());
  }

  void castVote({required String voter, required String target}) {
    if (!_isAlive(voter) || !_isAlive(target)) return;
    final others = state.votes.where((v) => v.voter != voter).toList();
    state = state.copyWith(votes: [...others, VoteEntry(voter: voter, target: target)]);
  }

  String? topVotedTarget() {
    final tally = <String, int>{};
    for (final v in state.votes) {
      tally[v.target] = (tally[v.target] ?? 0) + 1;
    }
    String? best;
    var bestCount = 0;
    tally.forEach((name, count) {
      if (count > bestCount) { best = name; bestCount = count; }
    });
    return best;
  }

  void executeTopVoted() {
    final target = topVotedTarget();
    if (target != null) {
      _kill(target);
      // Optional: reveal check here; state.revealOnDeath
    }
  }

  // Helpers
  bool _isAlive(String name) => state.players.any((p) => p.name == name && p.alive);

  String? _checkWin() {
    final roles = ref.read(roleCatalogProvider);
    int mafiaAlive = 0, townAlive = 0, indyAlive = 0;
    for (final p in state.players.where((p) => p.alive)) {
      final role = roles.firstWhere((r) => r.id == p.roleId, orElse: () => const Role(id: 'villager', name: 'Villager', align: AlignmentType.citizen));
      switch (role.align) {
        case AlignmentType.mafia: mafiaAlive++; break;
        case AlignmentType.citizen: townAlive++; break;
        case AlignmentType.independent: indyAlive++; break;
      }
    }
    if (mafiaAlive == 0 && indyAlive == 0 && townAlive > 0) return 'Town';
    if (mafiaAlive > 0 && mafiaAlive >= townAlive) return 'Mafia';
    // Simple indy rule: if only indy survives with others, refine later
    if (indyAlive > 0 && mafiaAlive == 0 && townAlive == 0) return 'Independent';
    return null;
  }

  // Manual overrides
  void toggleAlive(String name) {
    final idx = state.players.indexWhere((p) => p.name == name);
    if (idx == -1) return;
    final updated = [...state.players];
    updated[idx] = updated[idx].copyWith(alive: !updated[idx].alive);
    state = state.copyWith(players: updated);
  }
}