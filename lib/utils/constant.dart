import 'package:flutter/material.dart';

abstract class IAppColorAbstract {
  Color get primary;
  Color get secondary;
  Color get background;
  Color get textPrimary;
  Color get textSecondary;
  Color get success;
  Color get error;
  Color get favoriteIconBackground;
  Color get shadowColor;
  Color get lineColor;
  Color get clickColor;
  Color get promotionBadgeColor;
  Color get buttonBackgroundPrimary;
  Color get starColor;
  Color get greyColor;
  Color get readColor;
  Color get  chatMessageColor;
  Color get redColor;
}

abstract class IAppFontSizeAbstract {
  double get small;
  double get medium;
  double get large;
}