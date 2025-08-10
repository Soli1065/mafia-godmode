enum AlignmentType { citizen, mafia, independent }

extension AlignmentLabels on AlignmentType {
  String get label => switch (this) {
    AlignmentType.citizen => 'Citizen',
    AlignmentType.mafia => 'Mafia',
    AlignmentType.independent => 'Independent',
  };
}
