import 'package:ecommerce_mobile/components/avatar.dart';
import 'package:ecommerce_mobile/components/bottom_navigation_bar.dart';
import 'package:ecommerce_mobile/components/search_input.dart';
import 'package:ecommerce_mobile/components/swiper.dart';
import 'package:flutter/material.dart'; // Import the BrandAvatar widget

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
  final List<String> brandAssets = [
    'assets/images/google.png',
    'assets/images/facebook.png',
    'assets/images/shirt.jpg',
    'assets/images/shirt.jpeg',
    'assets/images/facebook.png',
    'assets/images/shirt.jpg',
    'assets/images/facebook.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Top row: menu, logo, icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                      tooltip: 'Menu',
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      width: 50,
                      height: 50,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shopping_cart),
                          tooltip: 'Cart',
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.message_sharp),
                          tooltip: 'Messages',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: SearchInput(),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Promotion',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwiperCard(),
          const SizedBox(height: 5),

          // Brand section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Brands',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => print('hello'),
                  icon: const Icon(Icons.arrow_forward),
                  tooltip: 'Arrow Forward',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: brandAssets.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Avatar(
                  asset: brandAssets[index],
                  // size: 60,
                  onTap: () {
                    print('Tapped ${brandAssets[index]}');
                  },
                );
              },
            ),
          ),

          // Categories section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => print('hello'),
                  icon: const Icon(Icons.arrow_forward),
                  tooltip: 'Arrow Forward',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: brandAssets.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Avatar(
                  asset: brandAssets[index],
                  // size: 60,
                  onTap: () {
                    print('Tapped ${brandAssets[index]}');
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 5),
        ],
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
