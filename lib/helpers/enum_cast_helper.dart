import 'package:my_to_do_app/helpers/enum_helper.dart';

class EnumCastHelper {
  static ThemeType themeEnumFromString(String type) {
    if (type == ThemeType.dark.name) {
      return ThemeType.dark;
    } else {
      return ThemeType.light;
    }
  }
}
