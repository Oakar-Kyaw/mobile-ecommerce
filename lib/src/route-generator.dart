import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/src/cart.page.dart';
import 'package:ecommerce_mobile/src/chat.page.dart';
import 'package:ecommerce_mobile/src/checkout.page.dart';
import 'package:ecommerce_mobile/src/favorite.page.dart';
import 'package:ecommerce_mobile/src/home.page.dart';
import 'package:ecommerce_mobile/src/login.dart';
import 'package:ecommerce_mobile/src/notification.page.dart';
import 'package:ecommerce_mobile/src/order-confirm.page.dart';
import 'package:ecommerce_mobile/src/order-history.page.dart';
import 'package:ecommerce_mobile/src/order.page.dart';
import 'package:ecommerce_mobile/src/promotion.page.dart';
import 'package:ecommerce_mobile/src/setting.page.dart';
import 'package:ecommerce_mobile/src/shipping-info.page.dart';
import 'package:ecommerce_mobile/src/sign-up.page.dart';
import 'package:ecommerce_mobile/src/trending-and-new-arrival-item.page.dart';
import 'package:ecommerce_mobile/src/product-detail.page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.home:
        return _buildPageRoute(const HomePage());
      case AppRoute.register:
        return _buildPageRoute(const SignUpPage());
      case AppRoute.login:
        return _buildPageRoute(const LoginPage());
      case AppRoute.promotion:
        return _buildPageRoute(const PromotionPage());
      case AppRoute.favorite:
        return _buildPageRoute(const FavoritePage());
      case AppRoute.setting:
        return _buildPageRoute(const SettingPage());
      case AppRoute.trendingItems:
        return _buildPageRoute(
          const TrendingAndNewArrivalItemPage(
            type: 'trending_items',
            title: "Trending Items",
          ),
        );
      case AppRoute.newArrivals:
        return _buildPageRoute(
          const TrendingAndNewArrivalItemPage(
            type: 'new_arrival_items',
            title: "New Arrivals",
          ),
        );
      case AppRoute.productDetail:
        return _buildPageRoute(
           const ProductDetailPage(),
        );
      case AppRoute.order:
        return _buildPageRoute(
           const OrderPage(),
        );
      case AppRoute.orderConfirm:
        return _buildPageRoute(
           const OrderConfirmPage(),
        );
      case AppRoute.orderHistory:
        return _buildPageRoute(
           const OrderHistoryPage(),
        );
      case AppRoute.checkout:
        return _buildPageRoute(
           const CheckoutPage(),
        );
      case AppRoute.chat:
        return _buildPageRoute(
           const ChatPage(),
        );
      case AppRoute.notifications:
        return _buildPageRoute(
           const NotificationPage(),
        );
      case AppRoute.cart:
        return _buildPageRoute(
           const CartPage(),
        );
      case AppRoute.shippingInfo:
        return _buildPageRoute(
           const ShippingInfoPage(),
        );
      default:
        return _buildPageRoute(const LoginPage());
    }
  }

  /// 🔥 Custom global transition (slide from right to left)
  static PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 100),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // from right
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
