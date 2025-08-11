// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
mixin _$Player {
  String get name => throw _privateConstructorUsedError;
  String get roleId => throw _privateConstructorUsedError;
  bool get alive => throw _privateConstructorUsedError;

  /// Serializes this Player to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call({String name, String roleId, bool alive});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? roleId = null,
    Object? alive = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      alive: null == alive
          ? _value.alive
          : alive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String roleId, bool alive});
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? roleId = null,
    Object? alive = null,
  }) {
    return _then(_$PlayerImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      roleId: null == roleId
          ? _value.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String,
      alive: null == alive
          ? _value.alive
          : alive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerImpl implements _Player {
  const _$PlayerImpl(
      {required this.name, required this.roleId, this.alive = true});

  factory _$PlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerImplFromJson(json);

  @override
  final String name;
  @override
  final String roleId;
  @override
  @JsonKey()
  final bool alive;

  @override
  String toString() {
    return 'Player(name: $name, roleId: $roleId, alive: $alive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.alive, alive) || other.alive == alive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, roleId, alive);

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerImplToJson(
      this,
    );
  }
}

abstract class _Player implements Player {
  const factory _Player(
      {required final String name,
      required final String roleId,
      final bool alive}) = _$PlayerImpl;

  factory _Player.fromJson(Map<String, dynamic> json) = _$PlayerImpl.fromJson;

  @override
  String get name;
  @override
  String get roleId;
  @override
  bool get alive;

  /// Create a copy of Player
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VoteEntry _$VoteEntryFromJson(Map<String, dynamic> json) {
  return _VoteEntry.fromJson(json);
}

/// @nodoc
mixin _$VoteEntry {
  String get voter => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;

  /// Serializes this VoteEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteEntryCopyWith<VoteEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteEntryCopyWith<$Res> {
  factory $VoteEntryCopyWith(VoteEntry value, $Res Function(VoteEntry) then) =
      _$VoteEntryCopyWithImpl<$Res, VoteEntry>;
  @useResult
  $Res call({String voter, String target});
}

/// @nodoc
class _$VoteEntryCopyWithImpl<$Res, $Val extends VoteEntry>
    implements $VoteEntryCopyWith<$Res> {
  _$VoteEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voter = null,
    Object? target = null,
  }) {
    return _then(_value.copyWith(
      voter: null == voter
          ? _value.voter
          : voter // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteEntryImplCopyWith<$Res>
    implements $VoteEntryCopyWith<$Res> {
  factory _$$VoteEntryImplCopyWith(
          _$VoteEntryImpl value, $Res Function(_$VoteEntryImpl) then) =
      __$$VoteEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String voter, String target});
}

/// @nodoc
class __$$VoteEntryImplCopyWithImpl<$Res>
    extends _$VoteEntryCopyWithImpl<$Res, _$VoteEntryImpl>
    implements _$$VoteEntryImplCopyWith<$Res> {
  __$$VoteEntryImplCopyWithImpl(
      _$VoteEntryImpl _value, $Res Function(_$VoteEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voter = null,
    Object? target = null,
  }) {
    return _then(_$VoteEntryImpl(
      voter: null == voter
          ? _value.voter
          : voter // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteEntryImpl implements _VoteEntry {
  const _$VoteEntryImpl({required this.voter, required this.target});

  factory _$VoteEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteEntryImplFromJson(json);

  @override
  final String voter;
  @override
  final String target;

  @override
  String toString() {
    return 'VoteEntry(voter: $voter, target: $target)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteEntryImpl &&
            (identical(other.voter, voter) || other.voter == voter) &&
            (identical(other.target, target) || other.target == target));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, voter, target);

  /// Create a copy of VoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteEntryImplCopyWith<_$VoteEntryImpl> get copyWith =>
      __$$VoteEntryImplCopyWithImpl<_$VoteEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteEntryImplToJson(
      this,
    );
  }
}

abstract class _VoteEntry implements VoteEntry {
  const factory _VoteEntry(
      {required final String voter,
      required final String target}) = _$VoteEntryImpl;

  factory _VoteEntry.fromJson(Map<String, dynamic> json) =
      _$VoteEntryImpl.fromJson;

  @override
  String get voter;
  @override
  String get target;

  /// Create a copy of VoteEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteEntryImplCopyWith<_$VoteEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameEvent _$GameEventFromJson(Map<String, dynamic> json) {
  return _GameEvent.fromJson(json);
}

/// @nodoc
mixin _$GameEvent {
  DateTime get at => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // e.g., 'night_kill', 'protect', 'investigate', 'vote', 'exec', 'phase'
  String get text => throw _privateConstructorUsedError;

  /// Serializes this GameEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameEventCopyWith<GameEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameEventCopyWith<$Res> {
  factory $GameEventCopyWith(GameEvent value, $Res Function(GameEvent) then) =
      _$GameEventCopyWithImpl<$Res, GameEvent>;
  @useResult
  $Res call({DateTime at, String type, String text});
}

/// @nodoc
class _$GameEventCopyWithImpl<$Res, $Val extends GameEvent>
    implements $GameEventCopyWith<$Res> {
  _$GameEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? at = null,
    Object? type = null,
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      at: null == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameEventImplCopyWith<$Res>
    implements $GameEventCopyWith<$Res> {
  factory _$$GameEventImplCopyWith(
          _$GameEventImpl value, $Res Function(_$GameEventImpl) then) =
      __$$GameEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime at, String type, String text});
}

/// @nodoc
class __$$GameEventImplCopyWithImpl<$Res>
    extends _$GameEventCopyWithImpl<$Res, _$GameEventImpl>
    implements _$$GameEventImplCopyWith<$Res> {
  __$$GameEventImplCopyWithImpl(
      _$GameEventImpl _value, $Res Function(_$GameEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? at = null,
    Object? type = null,
    Object? text = null,
  }) {
    return _then(_$GameEventImpl(
      at: null == at
          ? _value.at
          : at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameEventImpl implements _GameEvent {
  const _$GameEventImpl(
      {required this.at, required this.type, required this.text});

  factory _$GameEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameEventImplFromJson(json);

  @override
  final DateTime at;
  @override
  final String type;
// e.g., 'night_kill', 'protect', 'investigate', 'vote', 'exec', 'phase'
  @override
  final String text;

  @override
  String toString() {
    return 'GameEvent(at: $at, type: $type, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameEventImpl &&
            (identical(other.at, at) || other.at == at) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, at, type, text);

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      __$$GameEventImplCopyWithImpl<_$GameEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameEventImplToJson(
      this,
    );
  }
}

abstract class _GameEvent implements GameEvent {
  const factory _GameEvent(
      {required final DateTime at,
      required final String type,
      required final String text}) = _$GameEventImpl;

  factory _GameEvent.fromJson(Map<String, dynamic> json) =
      _$GameEventImpl.fromJson;

  @override
  DateTime get at;
  @override
  String
      get type; // e.g., 'night_kill', 'protect', 'investigate', 'vote', 'exec', 'phase'
  @override
  String get text;

  /// Create a copy of GameEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameEventImplCopyWith<_$GameEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  List<Player> get players => throw _privateConstructorUsedError;
  PhaseType get phase => throw _privateConstructorUsedError;
  int get cycle => throw _privateConstructorUsedError;
  int get secondsLeft => throw _privateConstructorUsedError;
  List<String> get nominations => throw _privateConstructorUsedError;
  List<VoteEntry> get votes =>
      throw _privateConstructorUsedError; // Night selections (MVP)
  String? get pendingNightKill =>
      throw _privateConstructorUsedError; // Mafia target (name)
  String? get doctorProtect =>
      throw _privateConstructorUsedError; // Doctor protection target (name)
  String? get detectiveTarget =>
      throw _privateConstructorUsedError; // Detective investigation target (name)
  String? get lastInvestigationResult =>
      throw _privateConstructorUsedError; // Cached result string for quick reference
  bool get revealOnDeath => throw _privateConstructorUsedError;
  bool get isRunning => throw _privateConstructorUsedError;
  String? get winnerFaction => throw _privateConstructorUsedError;
  List<GameEvent> get log => throw _privateConstructorUsedError;

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {List<Player> players,
      PhaseType phase,
      int cycle,
      int secondsLeft,
      List<String> nominations,
      List<VoteEntry> votes,
      String? pendingNightKill,
      String? doctorProtect,
      String? detectiveTarget,
      String? lastInvestigationResult,
      bool revealOnDeath,
      bool isRunning,
      String? winnerFaction,
      List<GameEvent> log});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
    Object? phase = null,
    Object? cycle = null,
    Object? secondsLeft = null,
    Object? nominations = null,
    Object? votes = null,
    Object? pendingNightKill = freezed,
    Object? doctorProtect = freezed,
    Object? detectiveTarget = freezed,
    Object? lastInvestigationResult = freezed,
    Object? revealOnDeath = null,
    Object? isRunning = null,
    Object? winnerFaction = freezed,
    Object? log = null,
  }) {
    return _then(_value.copyWith(
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as PhaseType,
      cycle: null == cycle
          ? _value.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as int,
      secondsLeft: null == secondsLeft
          ? _value.secondsLeft
          : secondsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      nominations: null == nominations
          ? _value.nominations
          : nominations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<VoteEntry>,
      pendingNightKill: freezed == pendingNightKill
          ? _value.pendingNightKill
          : pendingNightKill // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorProtect: freezed == doctorProtect
          ? _value.doctorProtect
          : doctorProtect // ignore: cast_nullable_to_non_nullable
              as String?,
      detectiveTarget: freezed == detectiveTarget
          ? _value.detectiveTarget
          : detectiveTarget // ignore: cast_nullable_to_non_nullable
              as String?,
      lastInvestigationResult: freezed == lastInvestigationResult
          ? _value.lastInvestigationResult
          : lastInvestigationResult // ignore: cast_nullable_to_non_nullable
              as String?,
      revealOnDeath: null == revealOnDeath
          ? _value.revealOnDeath
          : revealOnDeath // ignore: cast_nullable_to_non_nullable
              as bool,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
      winnerFaction: freezed == winnerFaction
          ? _value.winnerFaction
          : winnerFaction // ignore: cast_nullable_to_non_nullable
              as String?,
      log: null == log
          ? _value.log
          : log // ignore: cast_nullable_to_non_nullable
              as List<GameEvent>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Player> players,
      PhaseType phase,
      int cycle,
      int secondsLeft,
      List<String> nominations,
      List<VoteEntry> votes,
      String? pendingNightKill,
      String? doctorProtect,
      String? detectiveTarget,
      String? lastInvestigationResult,
      bool revealOnDeath,
      bool isRunning,
      String? winnerFaction,
      List<GameEvent> log});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? players = null,
    Object? phase = null,
    Object? cycle = null,
    Object? secondsLeft = null,
    Object? nominations = null,
    Object? votes = null,
    Object? pendingNightKill = freezed,
    Object? doctorProtect = freezed,
    Object? detectiveTarget = freezed,
    Object? lastInvestigationResult = freezed,
    Object? revealOnDeath = null,
    Object? isRunning = null,
    Object? winnerFaction = freezed,
    Object? log = null,
  }) {
    return _then(_$GameStateImpl(
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<Player>,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as PhaseType,
      cycle: null == cycle
          ? _value.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as int,
      secondsLeft: null == secondsLeft
          ? _value.secondsLeft
          : secondsLeft // ignore: cast_nullable_to_non_nullable
              as int,
      nominations: null == nominations
          ? _value._nominations
          : nominations // ignore: cast_nullable_to_non_nullable
              as List<String>,
      votes: null == votes
          ? _value._votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<VoteEntry>,
      pendingNightKill: freezed == pendingNightKill
          ? _value.pendingNightKill
          : pendingNightKill // ignore: cast_nullable_to_non_nullable
              as String?,
      doctorProtect: freezed == doctorProtect
          ? _value.doctorProtect
          : doctorProtect // ignore: cast_nullable_to_non_nullable
              as String?,
      detectiveTarget: freezed == detectiveTarget
          ? _value.detectiveTarget
          : detectiveTarget // ignore: cast_nullable_to_non_nullable
              as String?,
      lastInvestigationResult: freezed == lastInvestigationResult
          ? _value.lastInvestigationResult
          : lastInvestigationResult // ignore: cast_nullable_to_non_nullable
              as String?,
      revealOnDeath: null == revealOnDeath
          ? _value.revealOnDeath
          : revealOnDeath // ignore: cast_nullable_to_non_nullable
              as bool,
      isRunning: null == isRunning
          ? _value.isRunning
          : isRunning // ignore: cast_nullable_to_non_nullable
              as bool,
      winnerFaction: freezed == winnerFaction
          ? _value.winnerFaction
          : winnerFaction // ignore: cast_nullable_to_non_nullable
              as String?,
      log: null == log
          ? _value._log
          : log // ignore: cast_nullable_to_non_nullable
              as List<GameEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {final List<Player> players = const [],
      this.phase = PhaseType.night,
      this.cycle = 1,
      this.secondsLeft = 120,
      final List<String> nominations = const <String>[],
      final List<VoteEntry> votes = const <VoteEntry>[],
      this.pendingNightKill,
      this.doctorProtect,
      this.detectiveTarget,
      this.lastInvestigationResult,
      this.revealOnDeath = false,
      this.isRunning = false,
      this.winnerFaction,
      final List<GameEvent> log = const <GameEvent>[]})
      : _players = players,
        _nominations = nominations,
        _votes = votes,
        _log = log;

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  final List<Player> _players;
  @override
  @JsonKey()
  List<Player> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  @JsonKey()
  final PhaseType phase;
  @override
  @JsonKey()
  final int cycle;
  @override
  @JsonKey()
  final int secondsLeft;
  final List<String> _nominations;
  @override
  @JsonKey()
  List<String> get nominations {
    if (_nominations is EqualUnmodifiableListView) return _nominations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nominations);
  }

  final List<VoteEntry> _votes;
  @override
  @JsonKey()
  List<VoteEntry> get votes {
    if (_votes is EqualUnmodifiableListView) return _votes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_votes);
  }

// Night selections (MVP)
  @override
  final String? pendingNightKill;
// Mafia target (name)
  @override
  final String? doctorProtect;
// Doctor protection target (name)
  @override
  final String? detectiveTarget;
// Detective investigation target (name)
  @override
  final String? lastInvestigationResult;
// Cached result string for quick reference
  @override
  @JsonKey()
  final bool revealOnDeath;
  @override
  @JsonKey()
  final bool isRunning;
  @override
  final String? winnerFaction;
  final List<GameEvent> _log;
  @override
  @JsonKey()
  List<GameEvent> get log {
    if (_log is EqualUnmodifiableListView) return _log;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_log);
  }

  @override
  String toString() {
    return 'GameState(players: $players, phase: $phase, cycle: $cycle, secondsLeft: $secondsLeft, nominations: $nominations, votes: $votes, pendingNightKill: $pendingNightKill, doctorProtect: $doctorProtect, detectiveTarget: $detectiveTarget, lastInvestigationResult: $lastInvestigationResult, revealOnDeath: $revealOnDeath, isRunning: $isRunning, winnerFaction: $winnerFaction, log: $log)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.cycle, cycle) || other.cycle == cycle) &&
            (identical(other.secondsLeft, secondsLeft) ||
                other.secondsLeft == secondsLeft) &&
            const DeepCollectionEquality()
                .equals(other._nominations, _nominations) &&
            const DeepCollectionEquality().equals(other._votes, _votes) &&
            (identical(other.pendingNightKill, pendingNightKill) ||
                other.pendingNightKill == pendingNightKill) &&
            (identical(other.doctorProtect, doctorProtect) ||
                other.doctorProtect == doctorProtect) &&
            (identical(other.detectiveTarget, detectiveTarget) ||
                other.detectiveTarget == detectiveTarget) &&
            (identical(
                    other.lastInvestigationResult, lastInvestigationResult) ||
                other.lastInvestigationResult == lastInvestigationResult) &&
            (identical(other.revealOnDeath, revealOnDeath) ||
                other.revealOnDeath == revealOnDeath) &&
            (identical(other.isRunning, isRunning) ||
                other.isRunning == isRunning) &&
            (identical(other.winnerFaction, winnerFaction) ||
                other.winnerFaction == winnerFaction) &&
            const DeepCollectionEquality().equals(other._log, _log));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_players),
      phase,
      cycle,
      secondsLeft,
      const DeepCollectionEquality().hash(_nominations),
      const DeepCollectionEquality().hash(_votes),
      pendingNightKill,
      doctorProtect,
      detectiveTarget,
      lastInvestigationResult,
      revealOnDeath,
      isRunning,
      winnerFaction,
      const DeepCollectionEquality().hash(_log));

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(
      this,
    );
  }
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {final List<Player> players,
      final PhaseType phase,
      final int cycle,
      final int secondsLeft,
      final List<String> nominations,
      final List<VoteEntry> votes,
      final String? pendingNightKill,
      final String? doctorProtect,
      final String? detectiveTarget,
      final String? lastInvestigationResult,
      final bool revealOnDeath,
      final bool isRunning,
      final String? winnerFaction,
      final List<GameEvent> log}) = _$GameStateImpl;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  List<Player> get players;
  @override
  PhaseType get phase;
  @override
  int get cycle;
  @override
  int get secondsLeft;
  @override
  List<String> get nominations;
  @override
  List<VoteEntry> get votes; // Night selections (MVP)
  @override
  String? get pendingNightKill; // Mafia target (name)
  @override
  String? get doctorProtect; // Doctor protection target (name)
  @override
  String? get detectiveTarget; // Detective investigation target (name)
  @override
  String?
      get lastInvestigationResult; // Cached result string for quick reference
  @override
  bool get revealOnDeath;
  @override
  bool get isRunning;
  @override
  String? get winnerFaction;
  @override
  List<GameEvent> get log;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
