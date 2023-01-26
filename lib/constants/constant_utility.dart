import 'dart:ui';

class ConstantUtility {
  static String sunnyFont = "sunny";
  static Color fromHexToColor({
    required String hexCode,
  }) {
    return Color(int.parse(hexCode.replaceAll('#', '0xff').toUpperCase()));
  }
}
