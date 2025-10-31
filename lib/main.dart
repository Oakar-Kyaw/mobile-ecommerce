import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/src/route-generator.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/system-configuration-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🎨 Theme & Font Configurations
    final IAppColorAbstract colors = ref.watch(appColorProvider);
    final fontConfig = FontSizeConfiguration.appFontSize(context);

    return ShadApp.custom(
      themeMode: ThemeMode.light,

      // 🌕 Light Theme
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadSlateColorScheme.light(),
        textTheme: ShadTextTheme(family: 'Poppins'),
      ),

      // 🌑 Dark Theme
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
        textTheme: ShadTextTheme(family: 'Poppins'),
      ),

      // 🏗️ Wrap MaterialApp inside ShadApp
      appBuilder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoute.home,
          onGenerateRoute: RouteGenerator.generateRoute,

          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: colors.background,
            appBarTheme: AppBarTheme(
              backgroundColor: colors.background,
              foregroundColor: colors.primary,
            ),
            textTheme: Theme.of(context).textTheme
                .apply(
                  fontFamily: 'Poppins',
                  bodyColor: colors.primary,
                  displayColor: colors.primary,
                )
                .copyWith(
                  bodyLarge:
                      TextStyle(fontSize: fontConfig.large, fontFamily: 'Poppins'),
                  bodyMedium:
                      TextStyle(fontSize: fontConfig.medium, fontFamily: 'Poppins'),
                  bodySmall:
                      TextStyle(fontSize: fontConfig.small, fontFamily: 'Poppins'),
                ),
          ),

          // 🧠 Optional: Prevents text auto-scaling for consistent UI
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          ),
        );
      },
    );
  }
}
