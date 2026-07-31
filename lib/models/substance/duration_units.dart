enum DurationUnits {
  seconds('seconds', 's', 1),
  minutes('minutes', 'm', 60),
  hours('hours', 'h', 3600),
  days('days', 'd', 86400);

  const DurationUnits(this.text, this.shortText, this.inSecondsMultiplier);

  final String text;
  final String shortText;
  final int inSecondsMultiplier;
}
