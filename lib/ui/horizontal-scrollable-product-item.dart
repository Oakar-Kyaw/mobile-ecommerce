import 'package:ecommerce_mobile/components/card.dart';
import 'package:flutter/material.dart';

class HorizontalScrollableItem extends StatelessWidget {
  final List<Map<String, dynamic>> product;
  const HorizontalScrollableItem({
    Key? key,
   required this.product,
  }) : super(key: key);
  
 // final image = [];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: product.length,
      separatorBuilder: (context, index) => const SizedBox(width: 20),
      itemBuilder: (context, index) {
        return ProductCard(title: product[index]["title"], imageUrl: product[index]["imageUrl"], description: product[index]['description'], price: product[index]['price']);
      },
   );
  }
}