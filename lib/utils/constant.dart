import 'package:flutter/material.dart';

class AppPadding {
  static const double horizontal = 10.0;
  static const double vertical = 10.0;

  // You can also define EdgeInsets once
  static const EdgeInsets all = EdgeInsets.all(20);
  static const EdgeInsets horizontalOnly = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets verticalOnly = EdgeInsets.symmetric(vertical: 20);
}

class SmallAppFontSize {
   static const double small = 10.0;
   static const double medium = 12.0;
   static const double large = 14.0;
}

class MediumAppFontSize {
   static const double small = 12.0;
   static const double medium = 14.0;
   static const double large = 16.0;
}

class TabletAppFontSize {
   static const double small = 14.0;
   static const double medium = 16.0;
   static const double large = 18.0;
}

class LightModeColors {
  static const Color primary = Color.fromARGB(255, 23, 23, 23);
  static const Color secondary = Color.fromARGB(255, 226, 196, 7);
  static const Color background = Colors.white;
  //static const Color background = Color.fromARGB(255, 17, 15, 15);
  static const Color textPrimary = Color.fromARGB(255, 41, 36, 36);
  static const Color textSecondary = Color.fromARGB(255, 131, 126, 126);
  static const Color success = Color.fromARGB(255, 57, 160, 8);
  static const Color error = Color.fromARGB(255, 255, 0, 0);
  static const Color favoriteIconBackground = Color.fromARGB(255, 244, 241, 241);
  static const Color shadowColor = Color.fromARGB(255, 206, 203, 203);
}

class DarkModeColors {
  static const Color primary = Color(0xFFBB86FC);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Color(0xFF121212);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color success = Color(0xFF00C853);
  static const Color error = Color(0xFFFF5252);
}
