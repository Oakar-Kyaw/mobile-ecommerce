import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/fix-content.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/ui/vertical-scroll-item.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  final List<Map<String, dynamic>> categories = [
  {"id": 1, "name": "All"},
  {"id": 2, "name": "Electronics"},
  {"id": 3, "name": "Fashion"},
  {"id": 4, "name": "Home"},
  {"id": 5, "name": "Beauty"},
  {"id": 6, "name": "Toys"},
  {"id": 7, "name": "Sports"},
  {"id": 8, "name": "Books"},
  {"id": 9, "name": "Groceries"},
];


  String selectedCategory = "All";
  int selectedCategoryIndex = 0;

  void selectCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
      selectedCategory = categories[index]['name'] as String;
    });
  }
  
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Smartphone',
      'imageUrl': 'assets/images/smartphone.jpg',
      'description': 'Latest model smartphone with advanced features.',
      'price': 699.99
    },
    {
      'title': 'Running Shoes',
      'imageUrl': 'assets/images/sneaker.jpg',
      'description': 'Comfortable and durable running shoes.',
      'price': 89.99
    },
    {
      'title': 'Wireless Headphones',
      'imageUrl': 'assets/images/headphone.jpg',
      'description': 'Noise-cancelling over-ear headphone.jpg',
      'price': 199.99
    },
    {
      'title': 'Smartwatch',
      'imageUrl': 'assets/images/smartwatch.jpg',
      'description': 'Track your fitness and stay connected.',
      'price': 149.99
    },
    {
      "title": "Denim Jeans",
      "imageUrl": "assets/images/jean.jpg",
      "description": "Slim fit denim jeans with stretchable fabric.",
      "price": 55000,
      "currency": "MMK",
    },
    {
      "title": "Leather Jacket",
      "imageUrl": "assets/images/jacket.jpg",
      "description": "Premium black leather jacket with inner lining.",
      "price": 120000,
      "currency": "MMK"
    }
  ];

  @override
  void initState() {
    super.initState();
    //loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          config: config,
          leading: InkWell(child: Icon(Icons.arrow_back), onTap: () => Navigator.pop(context)), 
          title: "My Favorites"
        ),
        body: CustomScrollView(
         slivers: [
              // Fixed Categories + Search
        SliverPersistentHeader(
          pinned: true,
          delegate: FixedHeader(
            height: 130,
            config: config,
            //height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Items (5)"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SearchInput(),
                ),
              ],
            ),
          ),
        ),
            VerticalScrollItem(config: config,product: products, isFavorite: true),
          ],
        ),
      ),
    );
  }
}