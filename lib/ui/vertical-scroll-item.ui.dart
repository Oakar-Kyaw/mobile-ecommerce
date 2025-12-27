import 'package:ecommerce_mobile/components/product-card.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class VerticalScrollItem extends StatelessWidget {
  final List<Map<String, dynamic>> product;
  final bool isFavorite;
  final IAppColorAbstract config;
  const VerticalScrollItem({
    Key? key,
    this.isFavorite = true,
    required this.config,
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
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
          childAspectRatio: 0.5,
          mainAxisExtent: 340
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(
              id: "2",
              isFavorite: isFavorite,
              config: config,
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