enum StomachFullness {
  empty(
    text: 'Empty',
    serialized: 'EMPTY',
    onsetDelayForOralInHours: 0.0,
  ),
  quarterFull(
    text: 'Quarter full',
    serialized: 'QUARTERFULL',
    onsetDelayForOralInHours: 0.75,
  ),
  halfFull(
    text: 'Half full',
    serialized: 'HALFFULL',
    onsetDelayForOralInHours: 1.5,
  ),
  full(
    text: 'Full',
    serialized: 'FULL',
    onsetDelayForOralInHours: 3.0,
  ),
  veryFull(
    text: 'Very full',
    serialized: 'VERYFULL',
    onsetDelayForOralInHours: 4.0,
  );

  const StomachFullness({
    required this.text,
    required this.serialized,
    required this.onsetDelayForOralInHours,
  });

  final String text;
  final String serialized;
  final double onsetDelayForOralInHours;

  static StomachFullness fromSerialized(String value) {
    return StomachFullness.values.firstWhere(
      (e) => e.serialized == value,
      orElse: () => throw ArgumentError('$value is not a valid stomach fullness'),
    );
  }
}
