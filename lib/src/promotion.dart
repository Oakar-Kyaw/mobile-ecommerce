import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/categories-button.dart';
import 'package:ecommerce_mobile/ui/filter-component.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart'; // 👈 Import your button file

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  final List<String> categories = [
    "All",
    "Electronics",
    "Fashion",
    "Home",
    "Beauty",
    "Toys",
    "Sports",
    "Books",
    "Groceries",
  ];

  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(leading: Icons.arrow_back, lastIcon: Icons.shopping_cart, title: "Promotions"),
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
            Filter(),
            ]
          ),
        )
     );
  }
}
