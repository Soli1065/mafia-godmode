// lib/features/setup/setup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mafia_godmode/core/infrastructure/persistence.dart';

class SetupScreen extends ConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = ref.read(persistenceProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Start by selecting a Scenario and Roles in Catalog.'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/catalog'),
              child: const Text('Open Role Catalog'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    final ok = await p.loadAll();
                    final msg = ok ? 'Loaded previous session' : 'No saved session found';
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                      if (ok) context.go('/gm');
                    }
                  },
                  icon: const Icon(Icons.restore),
                  label: const Text('Resume Last Game'),
                ),
                const SizedBox(width: 12),
                TextButton.icon(
                  onPressed: () async {
                    await p.clearAll();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved data cleared')));
                    }
                  },
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Clear Saved Data'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}