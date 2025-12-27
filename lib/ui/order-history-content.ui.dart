
import 'package:ecommerce_mobile/components/order-card.component.dart';
import 'package:ecommerce_mobile/response/orderDetail.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/order-card.ui.dart';
import 'package:ecommerce_mobile/ui/shipping-card.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OrderContentUI extends ConsumerWidget {
  bool isOrderHistory;
  String id;
  String email;
  List<CartItem> cartItems;
  ShippingInfo shippingInfo;
  double totalAmount;
  double subTotal;
  double shippingFee;
  double tax;
  String currency;
  String paymentMethod;
  String? createdAt;

  final Widget message;

  OrderContentUI({
    super.key,
    required this.email,
    this.isOrderHistory = false,
    required this.cartItems ,
    required this.id,
    required this.message,
    required this.shippingInfo,
    required this.paymentMethod,
    required this.createdAt,
    this.totalAmount = 0,
    this.subTotal = 0,
    this.shippingFee = 0,
    this.tax = 0,
    this.currency = "MMK"
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
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
                            child: RichText(
                                text: TextSpan(
                                  style: TextStyle(color: config.primary),
                                  children: [
                                    TextSpan(text: "Your order "),
                                    TextSpan(text: id, style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: " has been placed. ")
                                  ]
                                )
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
                        TextSpan(text: email, style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " with your order confirmation and bill. ")
                      ]
                    )
                  ),
                //  Text("We sent an email to orders@banuelson.com with your order confirmation and bill. "),
                  const SizedBox(height: 20,),
                  Text("Time placed: $createdAt", style: TextStyle(fontWeight: FontWeight.bold),),

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
                   ShippingCard(name: shippingInfo.name, city: shippingInfo.city, email: shippingInfo.email, phone: shippingInfo.phone, address: shippingInfo.address)
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
                          child: paymentMethod == "KPAY" ?  Image.asset("assets/images/kpay.png") : paymentMethod == "WAVEPAY" ?  Image.asset("assets/images/wavepay.png") : Image.asset("assets/images/wavepay.png"),
                         ),
                       ),
                       SizedBox(width: 10,),
                       Text(paymentMethod, style: TextStyle(fontWeight: FontWeight.bold),)
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
                   message
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
                  color: cartItems[index].color,
                  existSizeField: true,
                  size: cartItems[index].size,
                  existQuantityButton: false,
                  realQuantity:(cartItems[index].quantity ),
                  name: cartItems[index].name,
                  brand: cartItems[index].brandName,
                  price: (cartItems[index].price as num).toDouble(),
                  currency: currency,
                  imageUrl: cartItems[index].imageUrl,
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
                OrderSummaryCard(
                  totalItem: cartItems.length,
                  totalAmount: totalAmount.toDouble(),
                  subTotal: subTotal.toDouble(),
                  shippingFee: shippingFee.toDouble(),
                  tax: tax.toDouble(),
                  currency: currency,
                ),
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
