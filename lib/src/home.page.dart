import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/bottom-navigation-bar.dart';
import 'package:ecommerce_mobile/components/divider.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/components/swiper.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/riverpod/theme-provider.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-avatar.ui.dart';
import 'package:ecommerce_mobile/ui/title.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_mobile/components/product-card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0; // Tracks the currently selected tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of brand logos
  final List<Map<String, dynamic>> brandAssets = [
  {
    'title': 'BMW',
    'imageUrl': 'assets/images/bmw.jpg',
  },
  {
    'title': 'Ford',
    'imageUrl': 'assets/images/ford.jpg',
  },
  {
    'title': 'Nike',
    'imageUrl': 'assets/images/nike.jpg',
  },
  {
    'title': 'Tesla',
    'imageUrl': 'assets/images/tesla.jpg',
  },
  {
    'title': 'Toyota',
    'imageUrl': 'assets/images/toyota.jpg',
  },
  {
    'title': 'Shirt Co.',
    'imageUrl': 'assets/images/shirt.jpg',
  },
  {
    'title': 'Facebook',
    'imageUrl': 'assets/images/facebook.png',
  },
];


  final List<Map<String, dynamic>> products = [
  {
    "title": "Classic White Shirt",
    "imageUrl": "assets/images/menshirt.jpg",
    "description": "Soft cotton white shirt, perfect for casual or formal wear.",
    "price": 40000,
    "currency": "MMK"
  },
  {
    "title": "Denim Jeans",
    "imageUrl": "assets/images/jean.jpg",
    "description": "Slim fit denim jeans with stretchable fabric.",
    "price": 55000,
    "currency": "MMK"
  },
  {
    "title": "Leather Jacket",
    "imageUrl": "assets/images/jacket.jpg",
    "description": "Premium black leather jacket with inner lining.",
    "price": 120000,
    "currency": "MMK"
  },
  {
    "title": "Sneakers",
    "imageUrl": "assets/images/sneaker.jpg",
    "description": "Comfortable and lightweight sneakers for everyday use.",
    "price": 65000,
    "currency": "MMK"
  },
  {
    "title": "Smart Watch",
    "imageUrl": "assets/images/smartwatch.jpg",
    "description": "Waterproof smartwatch with heart rate and sleep tracking.",
    "price": 850000,
    "currency": "MMK"
  },
];


  @override
  Widget build(BuildContext context) {
   
    final IAppColorAbstract config = ref.watch(appColorProvider);
    final currentTheme = ref.watch(themeModeProvider);
    print("Current Theme in Home Page: $currentTheme, $themeModeProvider");
    return Scaffold(
      backgroundColor: config.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(leading: GestureDetector(onTap: () {
          final newTheme = currentTheme == 'light' ? 'dark' : 'light';
          ref.read(themeModeProvider.notifier).setTheme(newTheme);
        },child: Icon(Icons.menu)), lastIcon: Icon(Icons.message), imageUrl: "assets/images/logo.png", trailing: Icon(Icons.shopping_cart)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),

        itemBuilder:(BuildContext context, index){ 
         return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search input
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SearchInput(),
            ),
            const SizedBox(height: 20),
    
            // Promotions
            TitleWidget('Promotions', isExistedIcon: false),
            const SizedBox(height: 10),
            SwiperCard(),
            const SizedBox(height: 5),
    
            // Brands section
            TitleWidget('Brands'),
            SizedBox(
              height: 100,
              child: HorizontalScrollableBrand(brands: brandAssets, isCheckBorderRadius: true)
            ),
    
            const SizedBox(height: 25),
            DoubleLineTriangleDivider(color: config.lineColor),
    
            // Categories section
            TitleWidget('Categories'),
            SizedBox(
              height: 100,
              child: HorizontalScrollableBrand(brands: brandAssets)
            ),

            const SizedBox(height: 25),
            DoubleLineTriangleDivider(color: config.lineColor),
            // FutureBuilder(
            //   future: Future.delayed(const Duration(seconds: 2)),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return TitleWidget(
            //         "Trending Items",
            //         onTap: () => Navigator.pushNamed(context, AppRoute.trendingItems),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
            TitleWidget(
                    "Trending Items",
                    onTap: () => Navigator.pushNamed(context, AppRoute.trendingItems),
            ),
            SizedBox(
              height: 320,
              child: HorizontalScrollableList<Map<String, dynamic>>(
                items: products,
                itemBuilder: (context, product, index) {
                  return ProductCard(
                    title: product["title"],
                    imageUrl: product["imageUrl"],
                    description: product["description"],
                    price: product["price"],
                    currency: product["currency"],
                  );
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(width: double.infinity, height: 1, color: config.textSecondary),
            ),
            // FutureBuilder(
            //   future: Future.delayed(const Duration(seconds: 2)),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       return TitleWidget(
            //         "New Arrivals",
            //         onTap: () => Navigator.pushNamed(context, AppRoute.newArrivals),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
             TitleWidget(
                    "New Arrivals",
                    onTap: () => Navigator.pushNamed(context, AppRoute.newArrivals),
                  ),
            SizedBox(
              height: 320,
              child: HorizontalScrollableList<Map<String, dynamic>>(
                items: products,
                itemBuilder: (context, product, index) {
                  return ProductCard(
                    title: product["title"],
                    imageUrl: product["imageUrl"],
                    description: product["description"],
                    price: product["price"],
                    currency: product["currency"],
                  );
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(width: double.infinity, height: 1, color: config.textSecondary),
            ),
            SizedBox(height: 40)

          ],
        );} ,
        itemCount: 1,
      ),
      bottomNavigationBar: CustomerBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        activeColor: config.primary,
        inactiveColor: config.textSecondary,
      ),
    );
  }
}
