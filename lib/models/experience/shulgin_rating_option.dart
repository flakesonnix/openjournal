enum ShulginRatingOption {
  minus(
    sign: '-',
    rawValue: 'minus',
    shortDescription: 'no effects',
    longDescription: 'On the quantitative potency scale (-, ±, +, ++, +++), there were no effects observed.',
    verticalSign: '-',
  ),
  plusMinus(
    sign: '±',
    rawValue: 'plusMinus',
    shortDescription: 'maybe false positive',
    longDescription: 'The level of effectiveness of a drug that indicates a threshold action. If a higher dosage produces a greater response, then the plus/minus (±) was valid. If a higher dosage produces nothing, then this was a false positive.',
    verticalSign: '±',
  ),
  plus(
    sign: '+',
    rawValue: 'plus',
    shortDescription: 'certainly active, nature not yet apparent',
    longDescription: 'The drug is quite certainly active. The chronology can be determined with some accuracy, but the nature of the drug\'s effects are not yet apparent.',
    verticalSign: '+',
  ),
  twoPlus(
    sign: '++',
    rawValue: 'twoPlus',
    shortDescription: 'nature apparent, effects may be repressible',
    longDescription: 'Both the chronology and the nature of the action of a drug are unmistakably apparent. But you still have some choice as to whether you will accept the adventure, or rather just continue with your ordinary day\'s plans (if you are an experienced researcher, that is). The effects can be allowed a predominant role, or they may be repressible and made secondary to other chosen activities.',
    verticalSign: '+\n+',
  ),
  threePlus(
    sign: '+++',
    rawValue: 'threePlus',
    shortDescription: 'totally engaged, ignoring no longer an option',
    longDescription: 'Not only are the chronology and the nature of a drug\'s action quite clear, but ignoring its action is no longer an option. The subject is totally engaged in the experience, for better or worse.',
    verticalSign: '+\n+\n+',
  ),
  fourPlus(
    sign: '++++',
    rawValue: 'fourPlus',
    shortDescription: 'rare and precious transcendental state',
    longDescription: 'A rare and precious transcendental state, which has been called a "peak experience," a "religious experience," "divine transformation," a "state of Samadhi" and many other names in other cultures. It is not connected to the +1, +2, and +3 of the measuring of a drug\'s intensity. It is a state of bliss, a participation mystique, a connectedness with both the interior and exterior universes, which has come about after the ingestion of a psychedelic drug, but which is not necessarily repeatable with a subsequent ingestion of that same drug. If a drug (or technique or process) were ever to be discovered which would consistently produce a plus four experience in all human beings, it is conceivable that it would signal the ultimate evolution, and perhaps the end, of the human experiment.',
    verticalSign: '+\n+\n+\n+',
  );

  const ShulginRatingOption({
    required this.sign,
    required this.rawValue,
    required this.shortDescription,
    required this.longDescription,
    required this.verticalSign,
  });

  final String sign;
  final String rawValue;
  final String shortDescription;
  final String longDescription;
  final String verticalSign;
}
