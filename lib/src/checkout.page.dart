import 'package:ecommerce_mobile/api/order.api.dart';
import 'package:ecommerce_mobile/api/shipping-address-info.api.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/response/item.dart';
import 'package:ecommerce_mobile/response/order.dart';
import 'package:ecommerce_mobile/response/orderItem.dart';
import 'package:ecommerce_mobile/response/shipping-data.dart';
import 'package:ecommerce_mobile/riverpod/order-calculation.dart';
import 'package:ecommerce_mobile/riverpod/shipping-info.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/order-card.ui.dart';
import 'package:ecommerce_mobile/ui/order-summary.ui.dart';
import 'package:ecommerce_mobile/ui/payment-method.ui.dart';
import 'package:ecommerce_mobile/utils/top-toast.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Scaffold, Divider, LucideIcons, Radio, RadioGroup, CircularProgressIndicator;
import 'package:shadcn_ui/shadcn_ui.dart';

/// ---------------------------
/// User Shipping Info Model
/// ---------------------------
// class UserShippingInfo {
//   final String id;
//   bool markDefault;
//   final String name;
//   final String email;
//   final String address;
//   final String phone;
//   final String title;

//   UserShippingInfo({
//     required this.id,
//     required this.markDefault,
//     required this.name,
//     required this.email,
//     required this.address,
//     required this.phone,
//     required this.title,
//   });

//   UserShippingInfo copyWith({
//     String? id,
//     bool? markDefault,
//     String? name,
//     String? email,
//     String? address,
//     String? phone,
//     String? title,
//   }) {
//     return UserShippingInfo(
//       id: id ?? this.id,
//       markDefault: markDefault ?? false,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       address: address ?? this.address,
//       phone: phone ?? this.phone,
//       title: title ?? this.title,
//     );
//   }

// }


/// ---------------------------
/// Checkout Page
/// ---------------------------
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {

  // Move these to class scope so modal can access them
  ShippingAddressInfo userShippingInfo = ShippingAddressInfo(
    id: "",
    markDefault: false,
    name: "",
    email: "",
    address: "",
    phone: "",
    addressTitle: "",
    country: "",
    city: ""
  );
  List<ShippingAddressInfo> userShippingInfoList = [];
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shippingInfoProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onQuantityChanged(int index, int newQuantity, List<Item>cartItems) {
    cartItems[index].quantity = newQuantity;
    final selectedCart = cartItems.where((item) => item.isChecked).toList();
    ref.read(orderItemProvider.notifier).addItem(
          itemList: selectedCart,
          shippingFee: 5,
          tax: 5,
        );
  }

  void changeDefault(String id) async{
    final response = await updateDefaultShippingAddressInfoApi(id, 58);
    if ( response["success"] == true && response["message"] == "ADDRESS_SET_DEFAULT") {
      TopToast.show(context: context, title: "Default Address's successfully setted");
      // refresh data
      ref.read(shippingInfoProvider.notifier).refresh();

      // close bottom sheet
      Navigator.of(context).pop();
    } else {
      // optional: show error
      TopToast.show(context: context, title: "Error making default address", icon: LucideIcons.x, iconColor: Colors.red);
    }
  }
  
  void navigateToShippingInfoPage()  async {
      final result = await Navigator.pushNamed(context, AppRoute.shippingInfo);
      if (result == true) {
          ref.read(shippingInfoProvider.notifier).refresh();
      }
 }
  
  void _submit() async{
      Order data = Order(
        userId: "58", 
        items: [
          OrderItem(
            productId: 1,
            quantity: 2,
            price: 50000,
            brandId: 57,
            size: "L",
            color: "#FFFF"
          ),
          OrderItem(
            productId: 2,
            quantity: 1,
            price: 30000,
            brandId: 57,
            size: "L",
            color: "#FFFF"
          ),
        ],
        totalAmount: 80000,
        subTotal: 75000,
        shippingFee: 3000,
        tax: 2000,
        currency: "MMK",
        existShippingAddress: true,
        paymentType: "KPAY",
        shippingAddressId: "69492b65f29698f74267d883"
      );
      final response = await createOrderApi(data);
      //Navigator.pushNamed(context, AppRoute.orderConfirm);
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appColorProvider);
    final cartState = ref.watch(orderItemProvider);
    final Items = cartState.items;
    final orderCalculation = cartState.calculation;

    final shippingState = ref.watch(shippingInfoProvider);
    final actualShippingInfoState = ref.read(actualShippingAddressInfoProvider.notifier);
    bool existAddressInfo = false;

    shippingState.when(
      data: (data) {
        if (data.isNotEmpty) {
          existAddressInfo = true;

         userShippingInfoList = data.map((e) => ShippingAddressInfo.fromJson(e)).toList();

          // Pick default for display
          final defaultAddress = userShippingInfoList.firstWhere(
            (info) => (data.firstWhere((a) => a["name"] == info.name))["markDefault"] == true,
            orElse: () => userShippingInfoList[0],
          );

          userShippingInfo = defaultAddress;
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) {},
    );

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
          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor)),

          /// Shipping Info Section
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text("Shipping", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    if (existAddressInfo)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            _handleBottomModalSheet(context);
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ),
                      ),
                  ],
                ),
                if (!existAddressInfo)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: config.greyColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: GestureDetector(
                        onTap: () => navigateToShippingInfoPage(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.local_shipping),
                                SizedBox(width: 20,),
                                Text("Add Info")
                              ],
                            ),
                            Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                    ),
                  ),
                if (existAddressInfo)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: config.greyColor,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userShippingInfo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(userShippingInfo.email, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(userShippingInfo.phone, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text(userShippingInfo.address,
                              overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor)),

          // Delivery info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: const Text("Delivered by Dec 31", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),

          // Order Items List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = Items[index];
                return OrderCard(
                  config: config,
                  existCheckBox: false,
                  realQuantity: item.quantity,
                  name: item.name,
                  brand: item.brand,
                  price: item.price,
                  currency: item.currency,
                  imageUrl: item.imageUrl,
                  quantity: item.quantity,
                  isChecked: false,
                  onQuantityChanged: (newQuantity) => _onQuantityChanged(index, newQuantity, Items),
                );
              },
              childCount: Items.length,
            ),
          ),

          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor)),

          // Payment Info
          SliverToBoxAdapter(
            child: PaymentMethodWidget(config: config, selectedMethod: ""),
          ),

          SliverToBoxAdapter(child: Divider(thickness: 5, color: config.greyColor)),

          // Order Summary
          SliverToBoxAdapter(
            child: OrderSummaryWidget(cartItems: Items),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${orderCalculation.total} MMK", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ShadButton(
                    backgroundColor: config.clickColor,
                    decoration: ShadDecoration(
                      color: config.background,
                      border: ShadBorder.all(radius: BorderRadius.circular(20)),
                    ),
                    child: const Text("Place order", style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => _submit()
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  /// -------------------------
  /// Bottom modal for shipping selection
  /// -------------------------
 void _handleBottomModalSheet(BuildContext context) {
  final config = ref.watch(appColorProvider);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, _) {
          final shippingState = ref.watch(shippingInfoProvider);

          return shippingState.when(
            data: (data) {
              // Map provider data to UserShippingInfo
              List<ShippingAddressInfo> userShippingInfoList = data.map((e)=>ShippingAddressInfo.fromJson(e)).toList();

              int selectedIndex = userShippingInfoList.indexWhere(
                  (e) => e.id == userShippingInfo.id
              );

              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Container(
                    height: 650,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: config.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text("Your Address", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: userShippingInfoList.length,
                            itemBuilder: (context, index) {
                              final info = userShippingInfoList[index];
                              bool isChecked = index == selectedIndex;

                              return GestureDetector(
                                onTap: () async {
                                  // Call API to change default address
                                  final response = await updateDefaultShippingAddressInfoApi(info.id!, 58);
                                  if (response["success"] == true &&
                                      response["message"] == "ADDRESS_SET_DEFAULT") {
                                    // Refresh provider
                                    await ref.read(shippingInfoProvider.notifier).refresh();

                                    // Update local state inside modal
                                    setModalState(() => selectedIndex = index);

                                    // Update CheckoutPage selected address
                                    setState(() => userShippingInfo = info);

                                    // Optionally close modal
                                    Navigator.of(context).pop();

                                    TopToast.show(
                                        context: context,
                                        title: "Default address successfully set");
                                  } else {
                                    TopToast.show(
                                      context: context,
                                      title: "Error setting default address",
                                      icon: LucideIcons.x,
                                      iconColor: Colors.red,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: config.greyColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Custom radio circle
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: isChecked ? config.clickColor : config.greyColor,
                                              width: 0.5),
                                        ),
                                        child: isChecked
                                            ? Center(
                                                child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: config.clickColor,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(info.addressTitle ?? "Default Address",
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis),
                                            const SizedBox(height: 4),
                                            Text(info.phone,
                                                style: const TextStyle(fontWeight: FontWeight.bold),
                                                overflow: TextOverflow.ellipsis),
                                            const SizedBox(height: 4),
                                            Text(info.address,
                                                overflow: TextOverflow.ellipsis),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ShadButton(
                            backgroundColor: config.clickColor,
                            decoration: ShadDecoration(
                              border: ShadBorder(radius: BorderRadius.circular(30.0)),
                            ),
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 40,
                            child: const Text(
                              "Add New Address",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.shippingInfo)
                                  .then((_) => ref.read(shippingInfoProvider.notifier).refresh());
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => const Center(child: Text("Failed to load addresses")),
          );
        },
      );
    },
  );
}

}
