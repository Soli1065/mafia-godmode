import 'package:freezed_annotation/freezed_annotation.dart';
import 'role.dart';
import 'phase.dart';
part 'game_models.freezed.dart';
part 'game_models.g.dart';

@freezed
class Player with _$Player {
  const factory Player({
    required String name,
    required String roleId, // secret to players; visible to GM
    @Default(true) bool alive,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}

@freezed
class VoteEntry with _$VoteEntry {
  const factory VoteEntry({
    required String voter, // player name
    required String target, // player name
  }) = _VoteEntry;

  factory VoteEntry.fromJson(Map<String, dynamic> json) => _$VoteEntryFromJson(json);
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([]) List<Player> players,
    @Default(PhaseType.night) PhaseType phase,
    @Default(1) int cycle,
    @Default(120) int secondsLeft, // timer for current phase
    @Default(<String>[]) List<String> nominations, // names
    @Default(<VoteEntry>[]) List<VoteEntry> votes,
    String? pendingNightKill, // selected target name
    @Default(false) bool revealOnDeath,
    @Default(false) bool isRunning, // timer running
    String? winnerFaction, // Town / Mafia / Independent
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
}