import 'package:ecommerce_mobile/components/product-card.dart';
import 'package:flutter/material.dart';

class VerticalScrollItem extends StatelessWidget {
  final List<Map<String, dynamic>> product;
  const VerticalScrollItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return SliverPadding with SliverGrid for CustomScrollView
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.5,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(
              title: product[index]["title"],
              imageUrl: product[index]["imageUrl"],
              description: product[index]['description'],
              price: product[index]['price'],
              currency: product[index]['currency'] ?? "USD",
              discountPrice: product[index]['discountPrice'],
            );
          },
          childCount: product.length,
        ),
      ),
    );
  }
}