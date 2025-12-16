import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/order-card.ui.dart';
import 'package:ecommerce_mobile/ui/order-summary.ui.dart';
import 'package:ecommerce_mobile/ui/payment-method.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
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

  final TextEditingController _addressController = TextEditingController();
  bool _agreeTerms = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  handleChangePayment(){

  }

  @override
  Widget build(BuildContext context) {
    // ✅ ref is now available
    final IAppColorAbstract config = ref.watch(appColorProvider);

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: "Checkout",
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor,)),
          
          //Shipping 
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoute.shippingInfo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Shipping", style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: config.greyColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(LucideIcons.truck),
                              const SizedBox(width: 10),
                              Text("Add Info")
                            ],
                          ),
                          Icon(Icons.arrow_right)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          
          SliverToBoxAdapter(child: SizedBox(height: 10,)),
          
          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor,)),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text("Delivered by Dec 31", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return OrderCard(
                  config: config,
                  existCheckBox: false,
                  realQuantity: 1,
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

          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor,)),

          //payment info
          SliverToBoxAdapter(
            child: PaymentMethodWidget(config: config, selectedMethod: "")
          ),

          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor,)),

          SliverToBoxAdapter(
            child: OrderSummaryWidget(config: config, cartItems: cartItems)
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: config.lineColor),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: config.greyColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(LucideIcons.ticketPercent),
                            const SizedBox(width: 10),
                            Text("Enter Discount Code")
                          ],
                        ),
                        GestureDetector(
                          child: Text("Apply", style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ),
          ),

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
                    child: Text("Place order", style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: () => Navigator.pushNamed(context, AppRoute.orderConfirm),
                  )
                ],
              ),
            ),
          ),
          
          SliverToBoxAdapter(child: SizedBox(height: 20,),)
        ],
      ),
    );
  }
}
