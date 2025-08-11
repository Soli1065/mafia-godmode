import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_godmode/core/application/gm_controller.dart';
import 'package:mafia_godmode/core/domain/phase.dart';

import '../../core/domain/game_models.dart';

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
                if (state.lastInvestigationResult != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(label: Text(state.lastInvestigationResult!)),
                  ),
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
                PhaseType.night => const _NightView(),
                PhaseType.day => const _DayView(),
                PhaseType.vote => const _VoteView(),
                PhaseType.exec => const _ExecView(),
                PhaseType.end => const _EndView(),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _NightView extends ConsumerWidget {
  const _NightView();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameStateProvider);
    final gm = ref.read(gameStateProvider.notifier);
    final alive = s.players.where((p) => p.alive).toList();

    Widget buildChips({required String title, required String? selected, required void Function(String? name) onSelect, bool allowNone = true}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(spacing: 8, runSpacing: 8, children: [
            if (allowNone)
              ChoiceChip(
                label: const Text('None'),
                selected: selected == null,
                onSelected: (_) => onSelect(null),
              ),
            for (final p in alive)
              ChoiceChip(
                label: Text(p.name),
                selected: selected == p.name,
                onSelected: (_) => onSelect(selected == p.name ? null : p.name),
              ),
          ]),
          const SizedBox(height: 12),
        ],
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildChips(
            title: 'Mafia chooses a target',
            selected: s.pendingNightKill,
            onSelect: gm.selectNightKill,
            allowNone: true,
          ),
          buildChips(
            title: 'Doctor protects',
            selected: s.doctorProtect,
            onSelect: gm.selectDoctorProtect,
            allowNone: true,
          ),
          buildChips(
            title: 'Detective investigates',
            selected: s.detectiveTarget,
            onSelect: gm.selectDetectiveTarget,
            allowNone: true,
          ),
          const Text('Tip: Use Next Phase to resolve and move to Day.'),
        ],
      ),
    );
  }
}

// Day/Vote/Exec/End views remain identical to your current implementation
class _DayView extends ConsumerWidget { const _DayView(); @override Widget build(BuildContext c, WidgetRef r){ final s=r.watch(gameStateProvider); final gm=r.read(gameStateProvider.notifier); final alive=s.players.where((p)=>p.alive).toList(); return Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ Text('Nominations', style: Theme.of(c).textTheme.titleLarge), const SizedBox(height:8), Wrap(spacing:8, runSpacing:8, children:[ for(final p in alive) FilterChip(label: Text(p.name), selected: s.nominations.contains(p.name), onSelected:(v)=> v? gm.nominate(p.name): gm.removeNomination(p.name)), ]), const SizedBox(height:8), const Text('Use Next Phase to start the Vote.'), ]); } }

class _VoteView extends ConsumerWidget { const _VoteView(); @override Widget build(BuildContext c, WidgetRef r){ final s=r.watch(gameStateProvider); final gm=r.read(gameStateProvider.notifier); final alive=s.players.where((p)=>p.alive).toList(); return Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ Text('Voting', style: Theme.of(c).textTheme.titleLarge), const SizedBox(height:8), Expanded(child: ListView.builder(itemCount: alive.length, itemBuilder:(context,i){ final voter=alive[i].name; final current=s.votes.firstWhere((v)=>v.voter==voter, orElse:()=>VoteEntry(voter: voter, target: '')); return Row(children:[ SizedBox(width:120,child: Text(voter)), const SizedBox(width:8), DropdownButton<String>( value: current.target.isEmpty? null: current.target, hint: const Text('Select target'), items: s.nominations.where((n)=>n!=voter).map((n)=>DropdownMenuItem(value:n, child: Text(n))).toList(), onChanged:(t){ if(t!=null) gm.castVote(voter: voter, target: t); }, ), ]); })), const SizedBox(height:8), FilledButton(onPressed: (){ final top=gm.topVotedTarget(); ScaffoldMessenger.of(c).showSnackBar(SnackBar(content: Text(top==null? 'No votes yet':'Top: $top'))); }, child: const Text('Preview Tally')), const SizedBox(height:8), const Text('Use Next Phase to proceed to Execution.'), ]); } }

class _ExecView extends ConsumerWidget { const _ExecView(); @override Widget build(BuildContext c, WidgetRef r){ final s=r.watch(gameStateProvider); final gm=r.read(gameStateProvider.notifier); final top=gm.topVotedTarget(); return Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ Text('Execution', style: Theme.of(c).textTheme.titleLarge), const SizedBox(height:8), if(top==null) const Text('No target selected. You can still toggle manually below.') else Card(child: ListTile(title: Text('Execute $top?'), trailing: FilledButton(onPressed: gm.executeTopVoted, child: const Text('Confirm')))), const SizedBox(height:12), Text('Manual Override'), const SizedBox(height:8), Wrap(spacing:8, runSpacing:8, children:[ for(final p in s.players) FilterChip(label: Text('${p.name} ${p.alive? '':'(dead)'}'), selected: !p.alive, onSelected:(_)=> gm.toggleAlive(p.name)), ]), const SizedBox(height:8), const Text('Use Next Phase to continue. Win check will run automatically.'), ]); } }

class _EndView extends ConsumerWidget { const _EndView(); @override Widget build(BuildContext c, WidgetRef r){ final s=r.watch(gameStateProvider); return Center(child: Column(mainAxisSize: MainAxisSize.min, children:[ Text('Game Over', style: Theme.of(c).textTheme.headlineMedium), const SizedBox(height:8), Text('Winner: ${s.winnerFaction ?? '-'}'), ])); } }
