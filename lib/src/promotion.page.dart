import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/fix-content.dart';
import 'package:ecommerce_mobile/ui/filter-component.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/ui/vertical-scroll-item.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart'; 

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
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
  
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Smartphone',
      'imageUrl': 'assets/images/smartphone.jpg',
      'description': 'Latest model smartphone with advanced features.',
      'price': 699.99,
      'discountPrice': 649.99,
    },
    {
      'title': 'Running Shoes',
      'imageUrl': 'assets/images/sneaker.jpg',
      'description': 'Comfortable and durable running shoes.',
      'price': 89.99,
      'discountPrice': 79.99,
    },
    {
      'title': 'Wireless Headphones',
      'imageUrl': 'assets/images/headphone.jpg',
      'description': 'Noise-cancelling over-ear headphone.jpg',
      'price': 199.99,
      'discountPrice': 149.99,
    },
    {
      'title': 'Smartwatch',
      'imageUrl': 'assets/images/smartwatch.jpg',
      'description': 'Track your fitness and stay connected.',
      'price': 149.99,
      'discountPrice': 129.99,
    },
    {
      "title": "Denim Jeans",
      "imageUrl": "assets/images/jean.jpg",
      "description": "Slim fit denim jeans with stretchable fabric.",
      "price": 55000,
      "currency": "MMK",
      "discountPrice": 50000
    },
    {
      "title": "Leather Jacket",
      "imageUrl": "assets/images/jacket.jpg",
      "description": "Premium black leather jacket with inner lining.",
      "price": 120000,
      "currency": "MMK",
      "discountPrice": 110000
    }
  ];

  @override
  void initState() {
    super.initState();
    //loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leading: GestureDetector(child: Icon(Icons.arrow_back), onTap: () => Navigator.pop(context)), 
          lastIcon: Icon(Icons.shopping_cart), 
          title: "Promotions"
        ),
        body: CustomScrollView(
         slivers: [
              // Fixed Categories + Search
        SliverPersistentHeader(
          pinned: true,
          delegate: FixedHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Horizontal categories
                SizedBox(
                  height: 40,
                  child: HorizontalScrollableList(
                    spacing: 10,
                    items: categories,
                    itemBuilder: (context, categories, index) {
                      return OutlinedButton( 
                        onPressed: () {
                          
                        },
                      child: Text(categories['name'], style: TextStyle(fontSize: 14, color: LightModeColors.primary)));
                    },
                  ),
                ),
      
                const SizedBox(height: 20),
      
                // Search input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchInput(),
                ),
      
                const SizedBox(height: 20),
      
                // Filter component
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Filter(),
                ),
              ],
            ),
          ),
        ),
            VerticalScrollItem(product: products),
          ],
        ),
      ),
    );
  }
}