import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/application/catalog_providers.dart';
import '../../core/domain/roles_catalog.dart';
import '../../core/domain/alignment.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(totalsProvider);
    final comp = ref.watch(compositionProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('Role Catalog'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _chip(context, 'Citizens', totals.citizen),
                    _chip(context, 'Mafia', totals.mafia),
                    _chip(context, 'Indep.', totals.independent),
                    _chip(context, 'Total', totals.total, filled: true),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Clear',
                onPressed: () => ref.read(compositionProvider.notifier).clear(),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _ScenariosBar(),
            ),
          ),
          ...AlignmentType.values.map((align) => SliverToBoxAdapter(
            child: _RoleSection(align: align),
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, String label, int value, {bool filled = false}) {
    final color = Theme.of(context).colorScheme.primary;
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: filled ? color.withOpacity(0.15) : null,
      shape: StadiumBorder(side: BorderSide(color: color.withOpacity(0.3))),
    );
  }
}

class _RoleSection extends ConsumerWidget {
  const _RoleSection({required this.align});
  final AlignmentType align;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roles = rolesByAlignment[align] ?? const [];
    final comp = ref.watch(compositionProvider);
    final notifier = ref.read(compositionProvider.notifier);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(align.label, style: Theme.of(context).textTheme.titleLarge),
        children: [
          for (final r in roles)
            ListTile(
              title: Text(r.name),
              subtitle: r.tags.isEmpty ? null : Text(r.tags.join(' • ')),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => notifier.dec(r.id),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${comp[r.id] ?? 0}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => notifier.inc(r.id),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ScenariosBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(scenariosProvider);
    final notifier = ref.read(compositionProvider.notifier);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final s in data)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ActionChip(
                label: Text(s.name),
                onPressed: () => notifier.applyScenario(s.composition),
              ),
            ),
        ],
      ),
    );
  }
}