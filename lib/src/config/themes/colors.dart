import 'package:flutter/material.dart' show Color, Colors, MaterialColor;

class AppColors {
  static const MaterialColor primary = MaterialColor(0xFF003893, <int, Color>{
    50: Color(0xFFF6F5F5),
    100: Color(0xFFD3E0EA),
    200: Color(0xFF003893),
    300: Color(0xFF003893),
  });
  static const Color black = Color(0xFF333333);
  static const Color greyDark = Color(0xFF999999);
  static const Color greyLight = Color(0xFFF3F4F8);
  static const Color secondary = Colors.pinkAccent;
  static const Color warning = Color(0xFFBD5D06);
  static const Color error = Color(0xFFA40E15);
  static const Color white = Color(0xffffffff);
}
