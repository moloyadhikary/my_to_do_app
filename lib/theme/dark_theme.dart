import 'package:my_to_do_app/helpers/color_helper.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

AppThemeProvider darkTheme = AppThemeProvider(
  g2Divider: ColorHelper.fromHex('#211f1f'),
  g3Border: ColorHelper.fromHex('#303030'),
  groundPrimary: ColorHelper.fromHex('#131314'),
  groundSecondary: ColorHelper.fromHex('#171717'),
  natural: ColorHelper.fromHex('#ffffff'),
  highEmphasize: ColorHelper.fromHex('#ffffff').withOpacity(0.80),
  midEmphasize: ColorHelper.fromHex('#ffffff').withOpacity(0.54),
  lowEmphasize: ColorHelper.fromHex('#ffffff').withOpacity(0.24),
);
