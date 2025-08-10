import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_godmode/core/application/catalog_providers.dart';
import 'package:mafia_godmode/core/domain/role.dart';

final playerNamesProvider = StateProvider<List<String>>((ref) => []);
final assignmentsProvider = StateProvider<Map<String, Role>>((ref) => {});

class AssignmentController {
  AssignmentController(this.ref);
  final Ref ref;

  void setPlayerCount(int count) {
    final names = List.generate(count, (i) => 'Player ${i + 1}');
    ref.read(playerNamesProvider.notifier).state = names;
  }

  void setPlayerName(int index, String name) {
    final names = [...ref.read(playerNamesProvider)];
    names[index] = name;
    ref.read(playerNamesProvider.notifier).state = names;
  }

  void randomize() {
    final roles = ref.read(roleCatalogProvider);
    final comp = ref.read(compositionProvider);
    final List<Role> pool = [];
    for (final entry in comp.entries) {
      final role = roles.firstWhere((r) => r.id == entry.key);
      for (int i = 0; i < entry.value; i++) {
        pool.add(role);
      }
    }
    pool.shuffle(Random());
    final names = ref.read(playerNamesProvider);
    final Map<String, Role> assignments = {};
    for (int i = 0; i < names.length && i < pool.length; i++) {
      assignments[names[i]] = pool[i];
    }
    ref.read(assignmentsProvider.notifier).state = assignments;
  }

  void clear() {
    ref.read(assignmentsProvider.notifier).state = {};
  }
}

final assignmentControllerProvider = Provider((ref) => AssignmentController(ref));