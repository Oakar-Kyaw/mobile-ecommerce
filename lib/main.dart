import 'package:ecommerce_mobile/src/app_route.dart';
import 'package:ecommerce_mobile/src/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define your global text style once
  static const globalTextStyle = TextStyle(fontFamily: 'Poppins', fontSize: 16);

  // Reusable Shad text theme
  static final globalShadTextTheme = ShadTextTheme(
    family: 'Poppins',
    p: globalTextStyle,
    small: globalTextStyle,
    large: globalTextStyle,
    lead: globalTextStyle,
    muted: globalTextStyle,
    h1: globalTextStyle,
    h2: globalTextStyle,
    h3: globalTextStyle,
    h4: globalTextStyle,
  );

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      themeMode: ThemeMode.light,

      // 🌕 Light Theme
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadSlateColorScheme.light(),
        textTheme: globalShadTextTheme,
      ),

      // 🌑 Dark Theme
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
        textTheme: globalShadTextTheme,
      ),

      appBuilder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.home,

          // 🩵 Apply same global style for Material widgets
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white, // ✅ AppBar background color
              foregroundColor: Colors.black, // text/icons color
              elevation: 0, // optional: remove shadow
            ),
            textTheme: Theme.of(context).textTheme
                .apply(
                  fontFamily: 'Poppins',
                  bodyColor: Colors.black,
                  displayColor: Colors.black,
                )
                .copyWith(
                  bodyLarge: globalTextStyle,
                  bodyMedium: globalTextStyle,
                  bodySmall: globalTextStyle,
                ),
          ),

          onGenerateRoute: RouteGenerator.generateRoute,
          builder: (context, child) {
            // Optional: scale text globally (e.g. for accessibility)
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}
