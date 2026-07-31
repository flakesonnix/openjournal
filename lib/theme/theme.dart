import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class OpenJournalTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: OpenJournalColors.lightColorScheme,
      textTheme: OpenJournalTypography.textTheme,
      scaffoldBackgroundColor: OpenJournalColors.lightBackground,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: OpenJournalColors.darkColorScheme,
      textTheme: OpenJournalTypography.textTheme,
      scaffoldBackgroundColor: OpenJournalColors.darkBackground,
    );
  }
}

const double horizontalPadding = 10.0;
const double verticalPaddingCards = 4.0;
const double minimumTouchTargetHeight = 48.0;
