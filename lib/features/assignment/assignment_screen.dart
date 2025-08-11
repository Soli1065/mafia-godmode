import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_godmode/core/application/assignment_provider.dart';

class AssignmentScreen extends ConsumerWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(playerNamesProvider);
    final assignments = ref.watch(assignmentsProvider);
    final controller = ref.read(assignmentControllerProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Players:'),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: names.isEmpty ? null : names.length,
                  hint: const Text('Count'),
                  items: List.generate(20, (i) => i + 1)
                      .map((n) => DropdownMenuItem(value: n, child: Text('$n')))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) controller.setPlayerCount(value);
                  },
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: controller.randomize,
                  icon: const Icon(Icons.shuffle),
                  label: const Text('Randomize'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, i) {
                  final name = names[i];
                  final role = assignments[name];
                  return ListTile(
                    leading: Text('${i + 1}'),
                    title: TextFormField(
                      initialValue: name,
                      onChanged: (val) => controller.setPlayerName(i, val),
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                    trailing: role == null
                        ? const Text('-')
                        : Text(role.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: controller.clear,
              child: const Text('Clear Assignments'),
            )
          ],
        ),
      ),
    );
  }
}