import 'dart:ui';

class ColorHelper {
  static Color fromHex(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      const fallbackColor = '#FFFFFF';
      final buffer = StringBuffer();
      if (fallbackColor.length == 6 || fallbackColor.length == 7) {
        buffer.write('ff');
      }
      buffer.write(fallbackColor.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }
}
