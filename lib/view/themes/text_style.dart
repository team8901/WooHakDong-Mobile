import 'package:flutter/material.dart';

/// 기본 폰트
const TextStyle baseTextStyle = TextStyle(
  color: Color(0xFF202020),
  fontFamily: 'Pretendard',
  leadingDistribution: TextLeadingDistribution.even,
  fontWeight: FontWeight.w400,
);

class CustomTextStyle {
  /// Header
  static TextStyle headerLarge = baseTextStyle.copyWith(
    fontSize: 24,
    height: 1.33,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headerSmall = baseTextStyle.copyWith(
    fontSize: 22,
    height: 1.36,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  /// Title
  static TextStyle titleLarge = baseTextStyle.copyWith(
    fontSize: 20,
    height: 1.3,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = baseTextStyle.copyWith(
    fontSize: 18,
    height: 1.33,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleSmall = baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.375,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  /// Body
  static TextStyle bodyLarge = baseTextStyle.copyWith(
    fontSize: 16,
    height: 1.375,
    letterSpacing: 0,
  );

  static TextStyle bodyMedium = baseTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodySmall = baseTextStyle.copyWith(
    fontSize: 14,
    height: 1.42,
    letterSpacing: 0,
  );

  // Label
  static TextStyle labelLarge = baseTextStyle.copyWith(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0,
  );
}
