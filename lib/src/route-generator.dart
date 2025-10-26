import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/src/home.dart';
import 'package:ecommerce_mobile/src/login.dart';
import 'package:ecommerce_mobile/src/promotion.dart';
import 'package:ecommerce_mobile/src/sign-up.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings);
    switch (settings.name) {
      case AppRoute.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoute.register:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoute.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoute.promotion:
        return MaterialPageRoute(builder: (_) => const PromotionPage());

      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
