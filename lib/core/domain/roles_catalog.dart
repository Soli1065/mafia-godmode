import 'role.dart';
import 'alignment.dart';

final List<Role> classicRoles = [
  // Citizens
  Role(id: 'villager', name: 'Villager', align: AlignmentType.citizen),
  Role(id: 'doctor', name: 'Doctor', align: AlignmentType.citizen, tags: ['protect']),
  Role(id: 'detective', name: 'Detective', align: AlignmentType.citizen, tags: ['investigate']),
  Role(id: 'guard', name: 'Bodyguard', align: AlignmentType.citizen, tags: ['protect','sacrifice']),
  Role(id: 'vigilante', name: 'Vigilante', align: AlignmentType.citizen, tags: ['kill']),
  // Mafia
  Role(id: 'mafia', name: 'Mafia', align: AlignmentType.mafia),
  Role(id: 'godfather', name: 'Godfather', align: AlignmentType.mafia, tags: ['leader']),
  Role(id: 'consigliere', name: 'Consigliere', align: AlignmentType.mafia, tags: ['investigate']),
  Role(id: 'silencer', name: 'Silencer', align: AlignmentType.mafia, tags: ['mute']),
  // Independent
  Role(id: 'serial_killer', name: 'Serial Killer', align: AlignmentType.independent, tags: ['kill']),
  Role(id: 'jester', name: 'Jester', align: AlignmentType.independent, tags: ['chaos']),
];

// Grouped for UI sections
final Map<AlignmentType, List<Role>> rolesByAlignment = {
  for (final a in AlignmentType.values)
    a: classicRoles.where((r) => r.align == a).toList(),
};