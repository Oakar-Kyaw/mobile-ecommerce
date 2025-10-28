class ThemeProvider {
  static const lightTheme = 'light';
  static const darkTheme = 'dark';

  static isDarkMode(String theme) {
    return theme == darkTheme;
  }
}