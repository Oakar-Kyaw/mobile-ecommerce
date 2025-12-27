import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';


class AppPadding {
  static const double horizontal = 10.0;
  static const double vertical = 10.0;

  static const EdgeInsets all = EdgeInsets.all(20);
  static const EdgeInsets horizontalOnly = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets verticalOnly = EdgeInsets.symmetric(vertical: 20);
}

class SmallAppFontSize implements IAppFontSizeAbstract {
  @override
  double get small =>  10.0;

  @override
  double get medium => 12.0;

  @override
  double get large => 14.0;
}

class MediumAppFontSize implements IAppFontSizeAbstract {
  @override
  double get small =>  12.0;

  @override
  double get medium => 14.0;

  @override
  double get large => 16.0;
}

class TabletAppFontSize implements IAppFontSizeAbstract {
  // @override
  // double get small =>  14.0;

  // @override
  // double get medium => 16.0;

  // @override
  // double get large => 18.0;
  @override
  double get small =>  30.0;

  @override
  double get medium => 40.0;

  @override
  double get large => 50.0;
}

class DesktopAppFontSize implements IAppFontSizeAbstract {
  @override
  double get small =>  16.0;

  @override
  double get medium => 18.0;

  @override
  double get large => 20.0;
}

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

  @override
  Color get clickColor => const Color.fromRGBO(55, 114, 174, 0.8);

  @override
  Color get promotionBadgeColor => const Color.fromRGBO(234, 245, 254, 1);

  @override
  Color get buttonBackgroundPrimary => const Color.fromRGBO(241, 243, 245, 1);

  @override
  Color get starColor => const Color.fromRGBO(254, 149, 34, 1);

  @override
  Color get greyColor => const Color.fromRGBO(241, 243, 245, 1);

  @override
  Color get readColor => const Color.fromARGB(255, 1, 68, 135);

  @override
  Color get chatMessageColor => const Color.fromARGB(255, 5, 104, 202);

  @override
  Color get redColor => const Color.fromARGB(255, 188, 15, 15);

  @override
  Color get lightBlue => const Color.fromRGBO(230, 243, 255, 1 );

  @override
  Color get lightGreen => const Color.fromRGBO(227, 255, 226, 1);

  @override
  Color get pending => const Color.fromRGBO(250, 204, 21, 1);

  @override
  Color get paid => const Color.fromRGBO(59, 130, 246, 1);

  @override
  Color get confirmed => const Color.fromRGBO(34, 197, 94, 1);

  @override
  Color get failed => const Color.fromARGB(255, 239, 68, 68);

  @override
  Color get shipped => const Color.fromRGBO(139, 92, 246, 1);

  @override
  Color get delivered => const Color.fromRGBO(22, 163, 74, 1);

  @override
  Color get cancelled => const Color.fromRGBO(107, 114, 128, 1);
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

  @override
  Color get clickColor => const Color.fromRGBO(55, 114, 175, 0.8);

  @override
  Color get promotionBadgeColor => const Color.fromRGBO(234, 245, 254, 1);

  @override
  Color get buttonBackgroundPrimary => const Color.fromRGBO(241, 243, 245, 1);

  @override
  Color get starColor => const Color.fromRGBO(254, 149, 34, 1);

  @override
  Color get greyColor => const Color.fromRGBO(189, 194, 202, 1);

  @override
  Color get readColor => const Color.fromARGB(255, 1, 68, 135);

  @override
  Color get chatMessageColor => const Color.fromARGB(255, 5, 104, 202);

  @override
  Color get redColor => const Color.fromRGBO(251, 56, 56, 1);

  @override
  Color get lightBlue => const Color.fromRGBO(230, 243, 255, 1 );

  @override
  Color get lightGreen => const Color.fromRGBO(227, 255, 226, 1);

  @override
  Color get pending => const Color.fromRGBO(250, 204, 21, 1);

  @override
  Color get paid => const Color.fromRGBO(59, 130, 246, 1);

  @override
  Color get confirmed => const Color.fromRGBO(34, 197, 94, 1);

  @override
  Color get failed => const Color.fromARGB(255, 239, 68, 68);

  @override
  Color get shipped => const Color.fromRGBO(139, 92, 246, 1);

  @override
  Color get delivered => const Color.fromRGBO(22, 163, 74, 1);

  @override
  Color get cancelled => const Color.fromRGBO(107, 114, 128, 1);
}

class FontSizeConfiguration {
  
  static isMobileScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 600;
  }

  static isTabletScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 600 && screenWidth < 1200;
  }

  static isDesktopScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 1200;
  }

  static IAppFontSizeAbstract appFontSize(BuildContext context) {
    print("Determining font size for screen width: ${isMobileScreen(context) ? 'Mobile' : isTabletScreen(context) ? 'Tablet' : isDesktopScreen(context) ? 'Desktop' : 'Unknown'}");
    switch (true) {
      case true when isMobileScreen(context):
        return MediumAppFontSize();
      case true when isTabletScreen(context):
        return TabletAppFontSize();
      case true when isDesktopScreen(context):
        return DesktopAppFontSize();
      default:  
        return MediumAppFontSize();
    }
}
}