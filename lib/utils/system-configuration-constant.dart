import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';


class AppPadding {
  static const double horizontal = 10.0;
  static const double vertical = 10.0;

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

// const Map<String, Color> lightModeColors = {
//   'primary': Color.fromARGB(255, 23, 23, 23),
//   'secondary': Color.fromARGB(255, 226, 196, 7),
//   'background': Colors.white,
//   'textPrimary': Color.fromARGB(255, 41, 36, 36),
//   'textSecondary': Color.fromARGB(255, 131, 126, 126),
//   'success': Color.fromARGB(255, 57, 160, 8),
//   'error': Color.fromARGB(255, 255, 0, 0),
//   'favoriteIconBackground': Color.fromARGB(255, 244, 241, 241),
//   'shadowColor': Color.fromARGB(255, 206, 203, 203),
// };

// const Map<String, Color> darkModeColors = {
//   'primary': Color(0xFFBB86FC),
//   'secondary': Color(0xFF03DAC6),
//   'background': Color(0xFF121212),
//   'textPrimary': Color(0xFFFFFFFF),
//   'textSecondary': Color(0xFFB3B3B3),
//   'success': Color(0xFF00C853),
//   'error': Color(0xFFFF5252),
// };

class LightAppColors implements IAppColorAbstract {
  @override
  Color get primary => const Color.fromARGB(255, 23, 23, 23);

  @override
  Color get secondary => const Color.fromARGB(255, 226, 196, 7);

  @override
  Color get background => Colors.white;

  @override
  Color get textPrimary => const Color.fromARGB(255, 41, 36, 36);

  @override
  Color get textSecondary => const Color.fromARGB(255, 131, 126, 126);

  @override
  Color get success => const Color.fromARGB(255, 57, 160, 8);

  @override
  Color get error => const Color.fromARGB(255, 255, 0, 0);

  @override
  Color get favoriteIconBackground => const Color.fromARGB(255, 244, 241, 241);

  @override
  Color get shadowColor => const Color.fromARGB(255, 206, 203, 203);

  @override
  Color get lineColor => const Color.fromARGB(255, 219, 215, 215);
}

class DarkAppColors implements IAppColorAbstract {
  @override
  Color get primary => const Color(0xFFBB86FC);

  @override
  Color get secondary => const Color(0xFF03DAC6);

  @override
  Color get background => const Color(0xFF121212);

  @override
  Color get textPrimary => const Color(0xFFFFFFFF);

  @override
  Color get textSecondary => const Color(0xFFB3B3B3);

  @override
  Color get success => const Color(0xFF00C853);

  @override
  Color get error => const Color(0xFFFF5252);

  @override
  Color get favoriteIconBackground => const Color(0xFF1E1E1E);

  @override
  Color get shadowColor => const Color(0xFF2C2C2C);

  @override
  Color get lineColor => const Color.fromARGB(255, 219, 215, 215);
}
