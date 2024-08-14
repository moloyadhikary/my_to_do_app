import 'package:flutter/material.dart';

class AppThemeProvider extends ThemeExtension<AppThemeProvider> {
  final Color groundPrimary;
  final Color groundSecondary;
  final Color g2Divider;
  final Color g3Border;
  final Color natural;
  final Color highEmphasize;
  final Color midEmphasize;
  final Color lowEmphasize;

  AppThemeProvider({
    required this.groundPrimary,
    required this.groundSecondary,
    required this.g2Divider,
    required this.g3Border,
    required this.natural,
    required this.highEmphasize,
    required this.midEmphasize,
    required this.lowEmphasize,
  });

  @override
  AppThemeProvider copyWith({
    Color? groundPrimary,
    Color? groundSecondary,
    Color? g2Divider,
    Color? g3Border,
    Color? natural,
    Color? highEmphasize,
    Color? midEmphasize,
    Color? lowEmphasize,
  }) {
    return AppThemeProvider(
      groundPrimary: groundPrimary ?? this.groundPrimary,
      groundSecondary: groundSecondary ?? this.groundSecondary,
      g2Divider: g2Divider ?? this.g2Divider,
      g3Border: g3Border ?? this.g3Border,
      natural: natural ?? this.natural,
      highEmphasize: highEmphasize ?? this.highEmphasize,
      midEmphasize: midEmphasize ?? this.midEmphasize,
      lowEmphasize: lowEmphasize ?? this.lowEmphasize,
    );
  }

  @override
  AppThemeProvider lerp(ThemeExtension<AppThemeProvider>? other, double t) {
    return this;
  }
}
