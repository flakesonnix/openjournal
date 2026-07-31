import 'package:flutter/material.dart';

enum AdaptiveColor {
  blue(isPreferred: true),
  pink(isPreferred: true),
  indigo(isPreferred: true),
  purple(isPreferred: true),
  cyan(isPreferred: true),
  teal(isPreferred: true),
  green(isPreferred: true),
  mint(isPreferred: true),
  yellow(isPreferred: true),
  orange(isPreferred: true),
  red(isPreferred: true),
  brown(isPreferred: false),
  grey(isPreferred: false);

  const AdaptiveColor({required this.isPreferred});

  final bool isPreferred;

  Color getComposeColor(bool isDarkTheme) {
    switch (this) {
      case AdaptiveColor.blue:
        return isDarkTheme ? const Color(0xFF007AFF) : const Color(0xFF007AFF);
      case AdaptiveColor.pink:
        return isDarkTheme ? const Color(0xFFFF2D55) : const Color(0xFFFF2D55);
      case AdaptiveColor.indigo:
        return isDarkTheme ? const Color(0xFF5856D6) : const Color(0xFF5856D6);
      case AdaptiveColor.purple:
        return isDarkTheme ? const Color(0xFFAF52DE) : const Color(0xFFAF52DE);
      case AdaptiveColor.cyan:
        return isDarkTheme ? const Color(0xFF32ADE6) : const Color(0xFF32ADE6);
      case AdaptiveColor.teal:
        return isDarkTheme ? const Color(0xFF30B0C7) : const Color(0xFF30B0C7);
      case AdaptiveColor.green:
        return isDarkTheme ? const Color(0xFF34C759) : const Color(0xFF34C759);
      case AdaptiveColor.mint:
        return isDarkTheme ? const Color(0xFF00C7BE) : const Color(0xFF00C7BE);
      case AdaptiveColor.yellow:
        return isDarkTheme ? const Color(0xFFFFCC00) : const Color(0xFFFFCC00);
      case AdaptiveColor.orange:
        return isDarkTheme ? const Color(0xFFFF9500) : const Color(0xFFFF9500);
      case AdaptiveColor.red:
        return isDarkTheme ? const Color(0xFFFF3B30) : const Color(0xFFFF3B30);
      case AdaptiveColor.brown:
        return isDarkTheme ? const Color(0xFFA2845E) : const Color(0xFFA2845E);
      case AdaptiveColor.grey:
        return isDarkTheme ? const Color(0xFF8E8E93) : const Color(0xFF8E8E93);
    }
  }
}
