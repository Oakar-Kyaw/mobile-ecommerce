import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/bottom-navigation-bar.dart';
import 'package:ecommerce_mobile/components/divider.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/components/swiper.dart';
import 'package:ecommerce_mobile/ui/horizontal-scrollable-brand.dart';
import 'package:ecommerce_mobile/ui/title.dart';
import 'package:ecommerce_mobile/ui/horizontal-scrollable-product-item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    "price": "40,000 MMK"
  },
  {
    "title": "Denim Jeans",
    "imageUrl": "assets/images/jean.jpg",
    "description": "Slim fit denim jeans with stretchable fabric.",
    "price": "55,000 MMK"
  },
  {
    "title": "Leather Jacket",
    "imageUrl": "assets/images/jacket.jpg",
    "description": "Premium black leather jacket with inner lining.",
    "price": "120,000 MMK"
  },
  {
    "title": "Sneakers",
    "imageUrl": "assets/images/sneaker.jpg",
    "description": "Comfortable and lightweight sneakers for everyday use.",
    "price": "65,000 MMK"
  },
  {
    "title": "Smart Watch",
    "imageUrl": "assets/images/smartwatch.jpg",
    "description": "Waterproof smartwatch with heart rate and sleep tracking.",
    "price": "85,000 MMK"
  },
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search input
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SearchInput(),
            ),
            const SizedBox(height: 5),
    
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
            const DoubleLineTriangleDivider(),
    
            // Categories section
            TitleWidget('Categories'),
            SizedBox(
              height: 100,
              child: HorizontalScrollableBrand(brands: brandAssets)
            ),

            const SizedBox(height: 25),
            const DoubleLineTriangleDivider(),
            TitleWidget("Trending Items"),
            SizedBox(
              height: 320,
              child: HorizontalScrollableItem(product: products),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(width: double.infinity, height: 1, color: const Color.fromARGB(255, 189, 189, 189)),
            ),
            TitleWidget("New Arrivals"),
            SizedBox(
              height: 320,
              child: HorizontalScrollableItem(product: products),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(width: double.infinity, height: 1, color: const Color.fromARGB(255, 189, 189, 189)),
            ),
            SizedBox(height: 40)

          ],
        ),
      ),
      bottomNavigationBar: CustomerBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        activeColor: Colors.black,
        inactiveColor: Colors.grey,
      ),
    );
  }
}
