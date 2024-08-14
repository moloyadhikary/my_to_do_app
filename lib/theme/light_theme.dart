import 'package:my_to_do_app/helpers/color_helper.dart';
import 'package:my_to_do_app/theme/app_theme_provider.dart';

AppThemeProvider lightTheme = AppThemeProvider(
  g2Divider: ColorHelper.fromHex('#eeeeee'),
  g3Border: ColorHelper.fromHex('#e0e0e0'),
  groundPrimary: ColorHelper.fromHex('#ffffff'),
  groundSecondary: ColorHelper.fromHex('#fafafa'),
  natural: ColorHelper.fromHex('#000000'),
  highEmphasize: ColorHelper.fromHex('#181818'),
  midEmphasize: ColorHelper.fromHex('#595959'),
  lowEmphasize: ColorHelper.fromHex('#aeaeae'),
);
