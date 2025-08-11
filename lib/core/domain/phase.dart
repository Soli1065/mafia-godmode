enum PhaseType { night, day, vote, exec, end }

extension PhaseLabel on PhaseType {
  String get label => switch (this) {
    PhaseType.night => 'Night',
    PhaseType.day => 'Day',
    PhaseType.vote => 'Voting',
    PhaseType.exec => 'Execution',
    PhaseType.end => 'Game Over',
  };
}