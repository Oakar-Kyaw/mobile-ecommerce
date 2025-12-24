
import 'package:ecommerce_mobile/response/item.dart';
import 'package:ecommerce_mobile/riverpod/shipping-info.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/order-card.ui.dart';
import 'package:ecommerce_mobile/ui/order-summary.ui.dart';
import 'package:ecommerce_mobile/ui/shipping-card.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OrderContentUI extends ConsumerWidget {
  final bool isOrderHistory;
  final String title;
  final List<Item> cartItems;
  final Widget message;
  const OrderContentUI({
    super.key,
    this.isOrderHistory = false,
    required this.cartItems ,
    required this.title,
    required this.message
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    final shippingInfo = ref.watch(actualShippingAddressInfoProvider);
    // final List<Map<String, dynamic>> cartItems = [
    //     {
    //       "name": "Short T-Shirt Black",
    //       "brand": "Adidas",
    //       "price": 200000,
    //       "imageUrl": "assets/images/jeanshirt.jpg",
    //       "quantity": 2,
    //       "isChecked": true,
    //     },
    //     {
    //       "name": "Classic White Shirt",
    //       "brand": "Nike",
    //       "price": 150000,
    //       "imageUrl": "assets/images/menshirt.jpg",
    //       "quantity": 1,
    //       "isChecked": false,
    //     },
    //     {
    //       "name": "Leather Jacket",
    //       "brand": "Zara",
    //       "price": 350000,
    //       "imageUrl": "assets/images/jacket.jpg",
    //       "quantity": 1,
    //       "isChecked": true,
    //     },
    //     {
    //       "name": "Denim Jeans",
    //       "brand": "Levi's",
    //       "price": 250000,
    //       "imageUrl": "assets/images/jean.jpg",
    //       "quantity": 3,
    //       "isChecked": false,
    //     },
    //     {
    //       "name": "Sneakers",
    //       "brand": "Puma",
    //       "price": 180000,
    //       "imageUrl": "assets/images/sneaker.jpg",
    //       "quantity": 1,
    //       "isChecked": true,
    //     },
    //   ];
    
    // 🔑 Status bar height
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return CustomScrollView(
        slivers: [
          // 🟢 Global page padding + status bar offset
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              20,
              statusBarHeight + 10, // ⬅ avoids status bar
              20,
              20,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // const SizedBox(height: 20),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                           color: Color.fromRGBO(60, 175, 71, 1),
                           shape: BoxShape.circle
                        ),
                        child: Center(child: Icon(LucideIcons.check, color: config.background, size: 40, weight: 50, fontWeight: FontWeight.bold,)),
                      ),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Thank you!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          SizedBox(
                            width: 250,
                            child: Text(
                              title, overflow: TextOverflow.clip
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: config.primary),
                      children: [
                        TextSpan(text: "We sent an email to "),
                        TextSpan(text: shippingInfo!.email, style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " with your order confirmation and bill. ")
                      ]
                    )
                  ),
                //  Text("We sent an email to orders@banuelson.com with your order confirmation and bill. "),
                  const SizedBox(height: 20,),
                  Text("Time placed: 17/02/2020 12:45 CEST", style: TextStyle(fontWeight: FontWeight.bold),),

                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: Divider(color: config.greyColor, thickness: 5,)),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                   Text("Shipping", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                   const SizedBox(height: 20,),
                   ShippingCard(name: shippingInfo!.name, email: shippingInfo.email, phone: shippingInfo.phone, address: shippingInfo.address)
                ]
              )
            ),
          ),
          SliverToBoxAdapter(child: Divider(color: config.greyColor, thickness: 5,)),
          
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                   Text("Payment Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                   const SizedBox(height: 10,),
                   Row(
                    children: [
                       SizedBox(
                         width: 40,
                         height: 40,
                         child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Image.asset("assets/images/wavepay.png"),
                         ),
                       ),
                       SizedBox(width: 10,),
                       Text("Wave Money", style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                   )
                ]
              )
            ),
          ),
          
          SliverToBoxAdapter(child: Divider(color: config.greyColor, thickness: 5,)),

          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                   Text("Order Items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                   const SizedBox(height: 10,),
                   Container(
                    padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       color: isOrderHistory ? config.lightGreen : config.lightBlue
                     ),
                     child:message,
                   )
                ]
              )
            ),
          ),
          
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 0, vertical: 10),
            sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return OrderCard(
                  config: config,
                  existCheckBox: false,
                  existColorField: true,
                  color: "Beige",
                  existSizeField: true,
                  size: "L",
                  existQuantityButton: false,
                  realQuantity: 1,
                  name: cartItems[index].name,
                  brand: cartItems[index].brand,
                  price: (cartItems[index].price as num).toDouble(),
                  currency: cartItems[index].currency,
                  imageUrl: cartItems[index].imageUrl,
                  quantity: (cartItems[index].quantity ),
                  isChecked: false,
                );
              },
              childCount: cartItems.length,
            ),
          ),
          ),
          SliverToBoxAdapter(child: Divider(color: config.greyColor, thickness: 5,)),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                OrderSummaryWidget(cartItems: cartItems),
                if(!isOrderHistory)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: config.lineColor, thickness: 1,),
                )
              ])
            ),
          ),
         if(!isOrderHistory)
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Expanded(
                      child: ShadButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoute.orderHistory),
                        backgroundColor: config.greyColor,
                        decoration: ShadDecoration(
                          border: ShadBorder.all(
                            radius:  BorderRadius.circular(20)
                          )
                        ),
                        child: Text("Order History", style: TextStyle(color: config.primary, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(width: 20,),
                     Expanded(
                       child: ShadButton(
                        onPressed: () => Navigator.pushNamed(context, AppRoute.home),
                        backgroundColor: config.clickColor,
                        decoration: ShadDecoration(
                          border: ShadBorder.all(
                            radius:  BorderRadius.circular(20)
                          )
                        ),
                        child: Text("Done", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                     ),
                  ],
                ),
                SizedBox(height: 30,)
              ])
            ),
          )
          
        ],
      );
  }
}
