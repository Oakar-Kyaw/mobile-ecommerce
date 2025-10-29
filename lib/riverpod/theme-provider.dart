import 'package:flutter_riverpod/flutter_riverpod.dart';

// "light" or "dark"
final themeModeProvider = NotifierProvider<ThemeModeNotifier, String>(() {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends Notifier<String> {
  @override
  String build() => 'light';

  void setTheme(String mode) {
    state = mode;
  }
}