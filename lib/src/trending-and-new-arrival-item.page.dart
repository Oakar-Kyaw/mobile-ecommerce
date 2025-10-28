import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/fix-content.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/ui/vertical-scroll-item.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class TrendingAndNewArrivalItemPage extends StatefulWidget {
  final String type;
  final String title;
  const TrendingAndNewArrivalItemPage({super.key, required this.type, required this.title});

  @override
  State<TrendingAndNewArrivalItemPage> createState() => _TrendingAndNewArrivalItemPageState();
}

class _TrendingAndNewArrivalItemPageState extends State<TrendingAndNewArrivalItemPage> {
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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leading: InkWell(child: Icon(Icons.arrow_back), onTap: () => Navigator.pop(context)), 
          lastIcon: Icon(Icons.search),
          title: widget.title
        ),
        body: CustomScrollView(
         slivers: [
              // Fixed Categories + Search
        SliverPersistentHeader(
          pinned: true,
          delegate: FixedHeader(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Horizontal categories
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  child: HorizontalScrollableList(
                    spacing: 20,
                    items: categories,
                    itemBuilder: (context, categories, index) {
                      print("categories: $index");
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(onTap: () => selectCategory(index), child: Text(categories['name'], style: TextStyle(fontSize: 14, color: selectedCategoryIndex == index ? LightModeColors.primary : LightModeColors.textSecondary))),
                          SizedBox(height: 5),
                          selectedCategoryIndex == index ? Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: LightModeColors.secondary,
                            ),
                          ) : const SizedBox(height:5)
                        ],
                      );
                    },
                  ),
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