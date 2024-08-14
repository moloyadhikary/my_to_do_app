import 'package:flutter/material.dart';
import 'package:my_to_do_app/helpers/enum_helper.dart';
import 'package:my_to_do_app/theme/dark_theme.dart';
import 'package:my_to_do_app/theme/light_theme.dart';

class ThemeHelper {
  static ThemeData getThemeData(ThemeType themeType) {
    if (themeType == ThemeType.dark) {
      return ThemeData(
        primarySwatch: Colors.amber,
        extensions: <ThemeExtension<dynamic>>[
          darkTheme,
        ],
      );
    } else {
      return ThemeData(
        primarySwatch: Colors.amber,
        extensions: <ThemeExtension<dynamic>>[
          lightTheme,
        ],
      );
    }
  }
}
