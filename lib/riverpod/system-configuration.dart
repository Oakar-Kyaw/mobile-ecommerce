
import 'package:ecommerce_mobile/riverpod/theme-provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/system-configuration-constant.dart';

// Provider that returns the appropriate color scheme based on theme mode
final appColorProvider = Provider<IAppColorAbstract>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  
  switch (themeMode) {
    case 'light':
      return LightAppColors();
    case 'dark':
      return DarkAppColors();
    default:
      return LightAppColors();
  }
});


final appFontSizeProvider = Provider<IAppFontSizeAbstract>((ref) {
  
  return MediumAppFontSize();
});