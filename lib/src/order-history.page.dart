import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/fix-content.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/ui/order-card.ui.dart';
import 'package:ecommerce_mobile/ui/order-history-content.ui.dart';
import 'package:ecommerce_mobile/ui/order-summary.ui.dart';
import 'package:ecommerce_mobile/ui/shipping-card.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OrderHistoryPage extends ConsumerWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    final List<Map<String, dynamic>> cartItems = [
        {
          "name": "Short T-Shirt Black",
          "brand": "Adidas",
          "price": 200000,
          "imageUrl": "assets/images/jeanshirt.jpg",
          "quantity": 2,
          "isChecked": true,
        },
        {
          "name": "Classic White Shirt",
          "brand": "Nike",
          "price": 150000,
          "imageUrl": "assets/images/menshirt.jpg",
          "quantity": 1,
          "isChecked": false,
        },
        {
          "name": "Leather Jacket",
          "brand": "Zara",
          "price": 350000,
          "imageUrl": "assets/images/jacket.jpg",
          "quantity": 1,
          "isChecked": true,
        },
        {
          "name": "Denim Jeans",
          "brand": "Levi's",
          "price": 250000,
          "imageUrl": "assets/images/jean.jpg",
          "quantity": 3,
          "isChecked": false,
        },
        {
          "name": "Sneakers",
          "brand": "Puma",
          "price": 180000,
          "imageUrl": "assets/images/sneaker.jpg",
          "quantity": 1,
          "isChecked": true,
        },
      ];
    // 🔑 Status bar height
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: CustomAppBar(config: config, title: "Order Detail", leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),),
      body: Text("hello history")
    //   OrderContentUI(isOrderHistory: true, cartItems: cartItems, title: "Your order #BE12345 has been Delivered.",
    //       message: Row(
    //       children: [
    //           SizedBox(
    //             width: 40,
    //             height: 40,
    //             child: Icon(LucideIcons.package),
    //           ),
    //           SizedBox(width: 5,),
    //           Text("Delivered by Oct 10 to Oct 20",)
    //       ],
    // )),
    
    );
  }
}
