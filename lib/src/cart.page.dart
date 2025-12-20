import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/response/cartItem.dart';
import 'package:ecommerce_mobile/riverpod/checkout-order-calculation.dart';
import 'package:ecommerce_mobile/riverpod/order-calculation.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/circle-component.ui.dart';
import 'package:ecommerce_mobile/ui/order-card.ui.dart';
import 'package:ecommerce_mobile/ui/order-summary.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  // Cart items state
  List<CartItem> cartItems = [
    CartItem(
      id: 1,
      name: "Short T-Shirt Black",
      brand: "Adidas",
      size: "L",
      color: "#ffff",
      currency: "MMK",
      price: 100,
      imageUrl: "assets/images/jeanshirt.jpg",
      quantity: 0,
      isChecked: false,
    ),
    CartItem(
      id: 2,
      name: "Classic White Shirt",
      brand: "Nike",
      size: "L",
      color: "#ffff",
      currency: "MMK",
      price: 200,
      imageUrl: "assets/images/menshirt.jpg",
      quantity: 0,
      isChecked: false,
    ),
    CartItem(
      id: 3,
      name: "Leather Jacket",
      brand: "Zara",
      size: "L",
      color: "#ffff",
      currency: "MMK",
      price: 350,
      imageUrl: "assets/images/jacket.jpg",
      quantity: 0,
      isChecked: false,
    ),
    CartItem(
      id: 4,
      name: "Denim Jeans",
      brand: "Levi's",
      size: "L",
      color: "#ffff",
      currency: "MMK",
      price: 450,
      imageUrl: "assets/images/jean.jpg",
      quantity: 3,
      isChecked: false,
    ),
    CartItem(
      id: 5,
      name: "Sneakers",
      brand: "Puma",
      size: "L",
      color: "#ffff",
      currency: "MMK",
      price: 500,
      imageUrl: "assets/images/sneaker.jpg",
      quantity: 0,
      isChecked: false,
    ),
  ];
  
  List<CartItem> selectedItem = [];

  void _recalculate( List<CartItem> cartlists ){
     print("carlist is ${cartlists.length}");
     double subTotal = 0;
     double shippingFee = 5;
     double tax = 5;
     double total = 0;
     int totalItems = cartlists.length;

     for (var item in cartlists) {
        subTotal += item.price * item.quantity;
     }
     total = subTotal + shippingFee + tax;
     ref.read(checkOutOrderCalculationDataProvider.notifier).save({
          "subTotal": subTotal,
          "total":  total,
          "shippingFee": shippingFee,
          "tax": tax,
          "totalItem": totalItems 
     });
  }

  // Update quantity
  void _onQuantityChanged(int index, int newQuantity ) {
    setState(() {
      cartItems[index].quantity = newQuantity;
    });
    
    final selectedCart = cartItems.where((items) => items.isChecked).toList();
    
    ref.read(orderItemProvider.notifier).addItem(itemList: selectedCart, shippingFee: 5, tax: 5);

    // if(cartItems[index].isChecked){
    //   ref.read(orderItemProvider.notifier).addItem(itemList: selectedCart, shippingFee: 5, tax: 5);
    // }
    //final selectedCart = cartItems.where((items) => items.isChecked).toList();
    
  //  _recalculate(selectedCart);
  }

  // Update checkbox
  void _onChecked(int index,  bool? checked) {

    setState(() {
      cartItems[index].isChecked = checked ?? false ;
    });

    final selectedCart = cartItems.where((items) => items.isChecked).toList();
    
    ref.read(orderItemProvider.notifier).addItem(itemList: selectedCart, shippingFee: 5, tax: 5);


   // _recalculate(selectedCart);
   // _updateTotals(price, quantity);
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appColorProvider);
    final orderState = ref.watch(orderItemProvider);
    final orderTotals = orderState.calculation;

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
          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = cartItems[index];
                return OrderCard(
                  config: config,
                  name: item.name,
                  brand: item.brand,
                  price: (item.price as num).toDouble(),
                  imageUrl: item.imageUrl,
                  currency: item.currency,
                  quantity: item.quantity,
                  isChecked: item.isChecked,
                  onQuantityChanged: ( newQuantity ) => _onQuantityChanged(index, newQuantity),
                  onChecked: (checked) => _onChecked(index, checked),
                );
              },
              childCount: cartItems.length,
            ),
          ),
          SliverToBoxAdapter(child: Divider(thickness: 8, color: config.greyColor)),
          SliverToBoxAdapter(
            child: OrderSummaryWidget(
              cartItems: cartItems,
             // shippingFee: orderTotals['shippingFee'],
             // tax: orderTotals['tax'],
            ),
          ),
          SliverToBoxAdapter(child: Divider(thickness: 10, color: config.greyColor)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${orderTotals.total} MMK", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ShadButton(
                    backgroundColor: config.clickColor,
                    decoration: ShadDecoration(
                      color: config.background,
                      border: ShadBorder.all(radius: BorderRadius.circular(20)),
                    ),
                    child: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => Navigator.pushNamed(context, AppRoute.checkout),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}
