import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}