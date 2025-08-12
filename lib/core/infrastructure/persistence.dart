// lib/core/infrastructure/persistence.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../application/catalog_providers.dart';
import '../application/assignment_provider.dart';
import '../application/gm_controller.dart';
import '../domain/game_models.dart';
import '../domain/role.dart';

const _boxName = 'mafia_persist';
const _kGameState = 'game_state';
const _kComposition = 'composition';
const _kAssignments = 'assignments';
const _kPlayerNames = 'player_names';

class PersistenceService {
  PersistenceService(this.ref);
  final Ref ref;

  Future<Box> _box() async => await Hive.openBox(_boxName);

  /// Save everything (called on changes)
  Future<void> saveAll() async {
    final box = await _box();

    // GameState
    final game = ref.read(gameStateProvider);
    await box.put(_kGameState, jsonEncode(game.toJson()));

    // Composition
    final comp = ref.read(compositionProvider);
    await box.put(_kComposition, jsonEncode(comp));

    // Assignments (Role map)
    final assigns = ref.read(assignmentsProvider);
    final assignsJson = assigns.map((k, v) => MapEntry(k, v.toJson()));
    await box.put(_kAssignments, jsonEncode(assignsJson));

    // Player names
    final names = ref.read(playerNamesProvider);
    await box.put(_kPlayerNames, jsonEncode(names));
  }

  /// Load everything (returns true if something loaded)
  Future<bool> loadAll() async {
    final box = await _box();
    bool loaded = false;

    // Player names
    final namesStr = box.get(_kPlayerNames) as String?;
    if (namesStr != null) {
      final names = (jsonDecode(namesStr) as List).cast<String>();
      ref.read(playerNamesProvider.notifier).state = names;
      loaded = true;
    }

    // Composition
    final compStr = box.get(_kComposition) as String?;
    if (compStr != null) {
      final comp = (jsonDecode(compStr) as Map).map((k, v) => MapEntry(k as String, v as int));
      ref.read(compositionProvider.notifier).applyScenario(comp);
      loaded = true;
    }

    // Assignments
    final assignStr = box.get(_kAssignments) as String?;
    if (assignStr != null) {
      final raw = (jsonDecode(assignStr) as Map).cast<String, dynamic>();
      final map = raw.map((k, v) => MapEntry(k, Role.fromJson(Map<String, dynamic>.from(v as Map))));
      ref.read(assignmentsProvider.notifier).state = map;
      loaded = true;
    }

    // GameState (set last—depends on players/roles existing)
    final gameStr = box.get(_kGameState) as String?;
    if (gameStr != null) {
      final game = GameState.fromJson(jsonDecode(gameStr) as Map<String, dynamic>);
      ref.read(gameStateProvider.notifier).overrideState(game);
      loaded = true;
    }

    return loaded;
  }

  Future<void> clearAll() async {
    final box = await _box();
    await box.delete(_kGameState);
    await box.delete(_kComposition);
    await box.delete(_kAssignments);
    await box.delete(_kPlayerNames);
  }
}

// Provider for service
final persistenceProvider = Provider<PersistenceService>((ref) => PersistenceService(ref));