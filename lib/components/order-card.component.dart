import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderSummaryCard extends ConsumerWidget {
  int totalItem;
  double totalAmount;
  double subTotal;
  double shippingFee;
  double tax;
  String currency;

  OrderSummaryCard({
    super.key,
    this.totalAmount = 0,
    this.totalItem = 0,
    this.subTotal= 0,
    this.shippingFee= 0,
    this.tax= 0,
    this.currency = "MMK"
  });

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

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // "Order Summary (${cartItems.length} items)",
             "Order Summary ($totalItem items)",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          _summaryRow("Item Subtotal", "$subTotal $currency", isBold: true),
          const SizedBox(height: 8),

          _summaryRow("Estimated Shipping Fee", "$shippingFee $currency", isBold: true),
          const SizedBox(height: 8),

          _summaryRow("Tax", "$tax $currency", isBold: true),
          const SizedBox(height: 10),

          Divider(color: config.lineColor),

          _summaryRow("Total", "$totalAmount $currency", isBold: true),
        ],
      ),
    );
  }
}
