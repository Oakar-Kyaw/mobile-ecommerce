import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/circle-component.ui.dart';
import 'package:ecommerce_mobile/ui/order-card.ui.dart';
import 'package:ecommerce_mobile/ui/order-summary.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

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

    // simulate cart items
   // final List<int> cartItems = List.generate(2, (index) => index);
    // change 2 → 100 to test long list

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: "Cart",
      ),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor,)),
          /// 🛒 CART ITEMS
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return OrderCard(
                  config: config,
                  name: cartItems[index]['name'],
                  brand: cartItems[index]['brand'],
                  price: (cartItems[index]['price'] as num).toDouble(),
                  imageUrl: cartItems[index]['imageUrl'],
                  quantity: (cartItems[index]['quantity'] as int),
                  isChecked: false,
                  onQuantityChanged: (newQuantity) {
                    print("New quantity: $newQuantity");
                  },
                  onChecked: (checked) {
                    print("Checkbox value: $checked");
                  },
                );
              },
              childCount: cartItems.length,
            ),
          ),
          SliverToBoxAdapter(child: Divider(thickness: 8, color: config.greyColor,)),
          /// 🧾 ORDER SUMMARY
          SliverToBoxAdapter(
            child: OrderSummaryWidget(config: config, cartItems: cartItems)
          ),
          SliverToBoxAdapter(child: Divider(thickness: 10, color: config.greyColor,)),
          /// 🔘 ACTION / NOTE
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("107,000 MMK", style: TextStyle(fontWeight: FontWeight.bold),),
                  ShadButton(
                    backgroundColor: config.clickColor,
                    decoration: ShadDecoration(
                      color: config.background,
                      border: ShadBorder.all(
                        radius: BorderRadius.circular(20)
                      )
                    ),
                    child: Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: () => Navigator.pushNamed(context, AppRoute.checkout),
                  )
                ],
              ),
            ),
          ),

          /// bottom spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ],
      ),
    );
  }
}
