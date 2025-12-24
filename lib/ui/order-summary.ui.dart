import 'package:ecommerce_mobile/response/item.dart';
import 'package:ecommerce_mobile/riverpod/order-calculation.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_mobile/utils/constant.dart';

class OrderSummaryWidget extends ConsumerWidget {
  final List<Item> cartItems; // Each item: {"price": 40000, "quantity": 2}
  final double shippingFee;
  final double tax;

  const OrderSummaryWidget({
    super.key,
    required this.cartItems,
    this.shippingFee = 5000,
    this.tax = 2000,
  });

  // Calculate subtotal dynamically
  // double get subtotal {
  //   return cartItems.fold(
  //     0,
  //     (sum, item) => sum + (item['price'] * item['quantity']),
  //   );
  // }

  // Total = subtotal + shipping + tax
  // double get total => subtotal + shippingFee + tax;

  // Reusable summary row
  Widget _summaryRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          value,
          style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch your app color provider
    final IAppColorAbstract config = ref.watch(appColorProvider);
    final orderCheckOut = ref.read(orderItemProvider);
    final orderCheckOutCalculation = orderCheckOut.calculation;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Order Summary (${cartItems.length} items)",
             "Order Summary (${orderCheckOutCalculation.totalItem} items)",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          _summaryRow("Item Subtotal", "${orderCheckOutCalculation.subTotal} MMK", isBold: true),
          const SizedBox(height: 8),

          _summaryRow("Estimated Shipping Fee", "${orderCheckOutCalculation.shippingFee} MMK", isBold: true),
          const SizedBox(height: 8),

          _summaryRow("Tax", "${orderCheckOutCalculation.tax} MMK", isBold: true),
          const SizedBox(height: 10),

          Divider(color: config.lineColor),

          _summaryRow("Total", "${orderCheckOutCalculation.total} MMK", isBold: true),
        ],
      ),
    );
  }
}
