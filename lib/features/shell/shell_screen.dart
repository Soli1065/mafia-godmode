import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mafia God Mode')),
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.tune), label: 'Setup'),
          NavigationDestination(icon: Icon(Icons.list), label: 'Catalog'),
          NavigationDestination(icon: Icon(Icons.assignment), label: 'Assign'),
          NavigationDestination(icon: Icon(Icons.timer), label: 'GM'),
          NavigationDestination(icon: Icon(Icons.flag), label: 'Summary'),
        ],
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go('/'); return;
            case 1: context.go('/catalog'); return;
            case 2: context.go('/assignment'); return;
            case 3: context.go('/gm'); return;
            case 4: context.go('/summary'); return;
          }
        },
        selectedIndex: switch (GoRouterState.of(context).fullPath) {
          '/' => 0,
          '/catalog' => 1,
          '/assignment' => 2,
          '/gm' => 3,
          '/summary' => 4,
          _ => 0,
        },
      ),
    );
  }
}