import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_godmode/core/domain/game_models.dart';
import 'package:mafia_godmode/core/domain/gm_controller.dart';
import 'package:mafia_godmode/core/domain/phase.dart';

class GmPanelScreen extends ConsumerWidget {
  const GmPanelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateProvider);
    final gm = ref.read(gameStateProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Cycle ${state.cycle} • ${state.phase.label}', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(width: 12),
                Chip(label: Text('T−${state.secondsLeft}s')),
                const Spacer(),
                FilledButton.icon(
                  onPressed: gm.toggleTimer,
                  icon: Icon(state.isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(state.isRunning ? 'Pause' : 'Start'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: gm.resetTimer, child: const Text('Reset')),
                const SizedBox(width: 8),
                FilledButton(onPressed: gm.nextPhase, child: const Text('Next Phase')),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: [
              FilledButton.icon(
                onPressed: gm.startFromAssignments,
                icon: const Icon(Icons.download),
                label: const Text('Load From Assignment'),
              ),
              if (state.winnerFaction != null)
                Chip(label: Text('Winner: ${state.winnerFaction}')),
            ]),
            const Divider(height: 24),

            Expanded(
              child: switch (state.phase) {
                PhaseType.night => _NightView(),
                PhaseType.day => _DayView(),
                PhaseType.vote => _VoteView(),
                PhaseType.exec => _ExecView(),
                PhaseType.end => _EndView(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NightView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameStateProvider);
    final gm = ref.read(gameStateProvider.notifier);
    final alive = s.players.where((p) => p.alive).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select night kill (MVP)', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8,
          children: [
            for (final p in alive)
              ChoiceChip(
                label: Text(p.name),
                selected: s.pendingNightKill == p.name,
                onSelected: (_) => gm.selectNightKill(
                  s.pendingNightKill == p.name ? null : p.name,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Tip: Use Next Phase to resolve and move to Day.'),
      ],
    );
  }
}

class _DayView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameStateProvider);
    final gm = ref.read(gameStateProvider.notifier);
    final alive = s.players.where((p) => p.alive).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nominations', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final p in alive)
            FilterChip(
              label: Text(p.name),
              selected: s.nominations.contains(p.name),
              onSelected: (v) => v ? gm.nominate(p.name) : gm.removeNomination(p.name),
            ),
        ]),
        const SizedBox(height: 8),
        const Text('Use Next Phase to start the Vote.'),
      ],
    );
  }
}

class _VoteView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameStateProvider);
    final gm = ref.read(gameStateProvider.notifier);
    final alive = s.players.where((p) => p.alive).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Voting', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: alive.length,
            itemBuilder: (context, i) {
              final voter = alive[i].name;
              return Row(
                children: [
                  SizedBox(width: 120, child: Text(voter)),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: s.votes.firstWhere(
                          (v) => v.voter == voter,
                      orElse: () => VoteEntry(voter: voter, target: ''),
                    ).target.isEmpty
                        ? null
                        : s.votes.firstWhere((v) => v.voter == voter).target,
                    hint: const Text('Select target'),
                    items: s.nominations
                        .where((name) => name != voter)
                        .map((name) => DropdownMenuItem(value: name, child: Text(name)))
                        .toList(),
                    onChanged: (target) {
                      if (target != null) {
                        gm.castVote(voter: voter, target: target);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () {
            final top = gm.topVotedTarget();
            final msg = top == null ? 'No votes yet' : 'Top: $top';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
          },
          child: const Text('Preview Tally'),
        ),
        const SizedBox(height: 8),
        const Text('Use Next Phase to proceed to Execution.'),
      ],
    );
  }
}

class _ExecView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameStateProvider);
    final gm = ref.read(gameStateProvider.notifier);
    final top = gm.topVotedTarget();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Execution', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        if (top == null) const Text('No target selected. You can still toggle manually below.'),
        if (top != null)
          Card(
            child: ListTile(
              title: Text('Execute $top?'),
              trailing: FilledButton(
                onPressed: gm.executeTopVoted,
                child: const Text('Confirm'),
              ),
            ),
          ),
        const SizedBox(height: 12),
        Text('Manual Override'),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final p in s.players)
            FilterChip(
              label: Text('${p.name} ${p.alive ? '' : '(dead)'}'),
              selected: !p.alive,
              onSelected: (_) => gm.toggleAlive(p.name),
            ),
        ]),
        const SizedBox(height: 8),
        const Text('Use Next Phase to continue. Win check will run automatically.'),
      ],
    );
  }
}

class _EndView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameStateProvider);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Game Over', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Winner: ${s.winnerFaction ?? '-'}'),
        ],
      ),
    );
  }
}