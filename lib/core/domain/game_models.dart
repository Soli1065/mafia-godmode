import 'package:freezed_annotation/freezed_annotation.dart';
import 'role.dart';
import 'phase.dart';
part 'game_models.freezed.dart';
part 'game_models.g.dart';

@freezed
class Player with _$Player {
  const factory Player({
    required String name,
    required String roleId,
    @Default(true) bool alive,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

@freezed
class VoteEntry with _$VoteEntry {
  const factory VoteEntry({
    required String voter,
    required String target,
  }) = _VoteEntry;

  factory VoteEntry.fromJson(Map<String, dynamic> json) => _$VoteEntryFromJson(json);
}

@freezed
class GameEvent with _$GameEvent {
  const factory GameEvent({
    required DateTime at,
    required String type,   // e.g., 'night_kill', 'protect', 'investigate', 'vote', 'exec', 'phase'
    required String text,   // human-readable
  }) = _GameEvent;

  factory GameEvent.fromJson(Map<String, dynamic> json) => _$GameEventFromJson(json);
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([]) List<Player> players,
    @Default(PhaseType.night) PhaseType phase,
    @Default(1) int cycle,
    @Default(120) int secondsLeft,
    @Default(<String>[]) List<String> nominations,
    @Default(<VoteEntry>[]) List<VoteEntry> votes,
    // Night selections (MVP)
    String? pendingNightKill,        // Mafia target (name)
    String? doctorProtect,           // Doctor protection target (name)
    String? detectiveTarget,         // Detective investigation target (name)
    String? lastInvestigationResult, // Cached result string for quick reference

    @Default(false) bool revealOnDeath,
    @Default(false) bool isRunning,
    String? winnerFaction,
    @Default(<GameEvent>[]) List<GameEvent> log,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
}