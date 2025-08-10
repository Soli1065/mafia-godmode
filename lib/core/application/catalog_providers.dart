import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/role.dart';
import '../domain/roles_catalog.dart';
import '../domain/alignment.dart';
import '../domain/scenario.dart';

/// Static catalog provider
final roleCatalogProvider = Provider<List<Role>>((ref) => classicRoles);

/// Composition state: roleId -> count
class CompositionNotifier extends StateNotifier<Composition> {
  CompositionNotifier(this._roles) : super({}) {
    // init with zeros for all roles for consistency
    for (final r in _roles) {
      state[r.id] = 0;
    }
  }
  final List<Role> _roles;

  void setCount(String roleId, int value) {
    state = {...state, roleId: value.clamp(0, 99)};
  }

  void inc(String roleId) => setCount(roleId, (state[roleId] ?? 0) + 1);
  void dec(String roleId) => setCount(roleId, (state[roleId] ?? 0) - 1);

  void applyScenario(Composition c) {
    final next = {...state};
    for (final e in c.entries) {
      next[e.key] = e.value;
    }
    state = next;
  }

  void clear() {
    state = {for (final r in _roles) r.id: 0};
  }
}

final compositionProvider =
StateNotifierProvider<CompositionNotifier, Composition>((ref) {
  final roles = ref.watch(roleCatalogProvider);
  return CompositionNotifier(roles);
});

/// Live counters for UI badges
class Totals {
  const Totals(this.citizen, this.mafia, this.independent, this.total);
  final int citizen;
  final int mafia;
  final int independent;
  final int total;
}

final totalsProvider = Provider<Totals>((ref) {
  final roles = ref.watch(roleCatalogProvider);
  final comp = ref.watch(compositionProvider);
  int c = 0, m = 0, i = 0;
  for (final r in roles) {
    final count = comp[r.id] ?? 0;
    switch (r.align) {
      case AlignmentType.citizen:
        c += count;
        break;
      case AlignmentType.mafia:
        m += count;
        break;
      case AlignmentType.independent:
        i += count;
        break;
    }
  }
  return Totals(c, m, i, c + m + i);
});

final scenariosProvider = Provider<List<ScenarioDef>>((ref) => scenarios);