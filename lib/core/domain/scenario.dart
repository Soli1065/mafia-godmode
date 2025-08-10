import 'role.dart';

/// Scenario = mapping roleId -> count
typedef Composition = Map<String, int>;

class ScenarioDef {
  ScenarioDef(this.id, this.name, this.composition);
  final String id;
  final String name;
  final Composition composition;
}

final List<ScenarioDef> scenarios = [
  ScenarioDef('classic10', 'Classic (10)', {
    'mafia': 2,
    'godfather': 0,
    'consigliere': 0,
    'silencer': 0,
    'detective': 1,
    'doctor': 1,
    'guard': 0,
    'vigilante': 0,
    'serial_killer': 0,
    'jester': 0,
    'villager': 6,
  }),
  ScenarioDef('classic12', 'Classic (12)', {
    'mafia': 3,
    'detective': 1,
    'doctor': 1,
    'villager': 7,
  }),
  ScenarioDef('zodiac_light', 'Zodiac (Light)', {
    'mafia': 2,
    'detective': 1,
    'doctor': 1,
    'serial_killer': 1,
    'villager': 5,
  }),
];