// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      name: json['name'] as String,
      roleId: json['roleId'] as String,
      alive: json['alive'] as bool? ?? true,
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'alive': instance.alive,
    };

_$VoteEntryImpl _$$VoteEntryImplFromJson(Map<String, dynamic> json) =>
    _$VoteEntryImpl(
      voter: json['voter'] as String,
      target: json['target'] as String,
    );

Map<String, dynamic> _$$VoteEntryImplToJson(_$VoteEntryImpl instance) =>
    <String, dynamic>{
      'voter': instance.voter,
      'target': instance.target,
    };

_$GameEventImpl _$$GameEventImplFromJson(Map<String, dynamic> json) =>
    _$GameEventImpl(
      at: DateTime.parse(json['at'] as String),
      type: json['type'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$$GameEventImplToJson(_$GameEventImpl instance) =>
    <String, dynamic>{
      'at': instance.at.toIso8601String(),
      'type': instance.type,
      'text': instance.text,
    };

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => Player.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      phase: $enumDecodeNullable(_$PhaseTypeEnumMap, json['phase']) ??
          PhaseType.night,
      cycle: (json['cycle'] as num?)?.toInt() ?? 1,
      secondsLeft: (json['secondsLeft'] as num?)?.toInt() ?? 120,
      nominations: (json['nominations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      votes: (json['votes'] as List<dynamic>?)
              ?.map((e) => VoteEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VoteEntry>[],
      pendingNightKill: json['pendingNightKill'] as String?,
      revealOnDeath: json['revealOnDeath'] as bool? ?? false,
      isRunning: json['isRunning'] as bool? ?? false,
      winnerFaction: json['winnerFaction'] as String?,
      log: (json['log'] as List<dynamic>?)
              ?.map((e) => GameEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <GameEvent>[],
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'players': instance.players,
      'phase': _$PhaseTypeEnumMap[instance.phase]!,
      'cycle': instance.cycle,
      'secondsLeft': instance.secondsLeft,
      'nominations': instance.nominations,
      'votes': instance.votes,
      'pendingNightKill': instance.pendingNightKill,
      'revealOnDeath': instance.revealOnDeath,
      'isRunning': instance.isRunning,
      'winnerFaction': instance.winnerFaction,
      'log': instance.log,
    };

const _$PhaseTypeEnumMap = {
  PhaseType.night: 'night',
  PhaseType.day: 'day',
  PhaseType.vote: 'vote',
  PhaseType.exec: 'exec',
  PhaseType.end: 'end',
};
