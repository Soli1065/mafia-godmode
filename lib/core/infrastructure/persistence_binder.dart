import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'persistence.dart';
import '../application/catalog_providers.dart';
import '../application/assignment_provider.dart';
import '../application/gm_controller.dart';

/// Mount this once (e.g., wrapping ShellScreen body).
/// Registers Riverpod listeners that autosave on any relevant change.
class PersistenceBinder extends ConsumerWidget {
  const PersistenceBinder({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Each ref.listen registered here is automatically disposed on rebuild/unmount.
    ref.listen(gameStateProvider, (prev, next) {
      ref.read(persistenceProvider).saveAll();
    });

    ref.listen(compositionProvider, (prev, next) {
      ref.read(persistenceProvider).saveAll();
    });

    ref.listen(assignmentsProvider, (prev, next) {
      ref.read(persistenceProvider).saveAll();
    });

    ref.listen(playerNamesProvider, (prev, next) {
      ref.read(persistenceProvider).saveAll();
    });

    return child;
  }
}