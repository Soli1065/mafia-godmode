import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html; // for web download
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_godmode/core/application/gm_controller.dart';
import 'package:mafia_godmode/core/domain/game_models.dart';
import 'package:mafia_godmode/core/domain/roles_catalog.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(gameStateProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Summary', style: Theme.of(context).textTheme.headlineSmall),
                const Spacer(),
                if (s.winnerFaction != null)
                  Chip(label: Text('Winner: ${s.winnerFaction}')),
              ],
            ),
            const SizedBox(height: 12),
            _PlayersTable(state: s),
            const Divider(height: 24),
            Text('Timeline', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: s.log.length,
                itemBuilder: (context, i) {
                  final e = s.log[i];
                  return ListTile(
                    dense: true,
                    leading: Text(e.type),
                    title: Text(e.text),
                    subtitle: Text(e.at.toLocal().toIso8601String()),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                FilledButton.icon(
                  onPressed: () => _copySummary(context, s),
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy as text'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _downloadText('mafia_summary.txt', _buildSummaryText(s)),
                  icon: const Icon(Icons.download),
                  label: const Text('Download .txt'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _downloadJson('mafia_summary.json', s),
                  icon: const Icon(Icons.data_object),
                  label: const Text('Download .json'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copySummary(BuildContext context, GameState s) async {
    final text = _buildSummaryText(s);
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Summary copied to clipboard')));
    }
  }

  String _buildSummaryText(GameState s) {
    final buf = StringBuffer();
    buf.writeln('Mafia Game Summary');
    if (s.winnerFaction != null) buf.writeln('Winner: ${s.winnerFaction}');
    buf.writeln('Cycles: ${s.cycle}');
    buf.writeln('');

    buf.writeln('Players:');
    for (final p in s.players) {
      final roleName = classicRoles.firstWhere((r) => r.id == p.roleId, orElse: () => classicRoles.first).name;
      buf.writeln(' - ${p.name}  [${p.alive ? 'alive' : 'dead'}]  ($roleName)');
    }
    buf.writeln('');

    buf.writeln('Timeline:');
    for (final e in s.log) {
      buf.writeln(' - [${e.at.toLocal().toIso8601String()}] ${e.type}: ${e.text}');
    }
    return buf.toString();
  }

  void _downloadText(String filename, String contents) {
    if (!kIsWeb) return; // web-only for now
    final bytes = utf8.encode(contents);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  void _downloadJson(String filename, GameState s) {
    if (!kIsWeb) return;
    final jsonStr = const JsonEncoder.withIndent('  ').convert(s.toJson());
    _downloadText(filename, jsonStr);
  }
}

class _PlayersTable extends ConsumerWidget {
  const _PlayersTable({required this.state});
  final GameState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Players', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Table(
              columnWidths: const {
                0: FixedColumnWidth(160),
                1: FixedColumnWidth(120),
                2: FlexColumnWidth(),
              },
              children: [
                const TableRow(children: [
                  Padding(padding: EdgeInsets.all(4), child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(4), child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(padding: EdgeInsets.all(4), child: Text('Role', style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
                ...state.players.map((p) {
                  final roleName = classicRoles.firstWhere((r) => r.id == p.roleId, orElse: () => classicRoles.first).name;
                  return TableRow(children: [
                    Padding(padding: const EdgeInsets.all(4), child: Text(p.name)),
                    Padding(padding: const EdgeInsets.all(4), child: Text(p.alive ? 'Alive' : 'Dead')),
                    Padding(padding: const EdgeInsets.all(4), child: Text(roleName)),
                  ]);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}