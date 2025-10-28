import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/src/route-generator.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/rendering.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //debugPaintSizeEnabled = true; 
  // await Firebase.initializeApp(
  //   // options: FirebaseOptions(apiKey: apiKey, appId: appId, messagingSenderId: messagingSenderId, projectId: projectId)
  //   options: FirebaseOptions(apiKey: "AIzaSyASfbzwMvS8_12u5ViMpiAm2xga-wkE5tM", appId: "1:566223411513:android:5a5412fea0a1ecde4cb0e8", messagingSenderId: "566223411513", projectId: "megasmartcart-771d3"),
  // );
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: const MyApp()));
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
      // theme: ShadThemeData(
      //   brightness: Brightness.light,
      //   colorScheme: const ShadSlateColorScheme.light(),
      //   textTheme: globalShadTextTheme,
      // ),

      // // 🌑 Dark Theme
      // darkTheme: ShadThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: const ShadSlateColorScheme.dark(),
      //   textTheme: globalShadTextTheme,
      // ),

      appBuilder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.home,
          // 🩵 Apply same global style for Material widgets
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: LightModeColors.background,
            appBarTheme: const AppBarTheme(
              backgroundColor: LightModeColors.background, // ✅ AppBar background color
              foregroundColor: LightModeColors.primary, // text/icons color
              //elevation: 5, // optional: remove shadow
            ),
            textTheme: Theme.of(context).textTheme
                .apply(
                  fontFamily: 'Poppins',
                  bodyColor: LightModeColors.primary,
                  displayColor: LightModeColors.primary,
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
