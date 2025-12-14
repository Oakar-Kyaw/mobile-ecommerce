import 'package:flutter/material.dart';
import 'package:ecommerce_mobile/utils/constant.dart';

class OrderSummaryWidget extends StatelessWidget {
  final IAppColorAbstract config;
  final List<Map<String, dynamic>> cartItems; // Each item: {"price": 40000, "quantity": 2}
  final int shippingFee;
  final int tax;

  const OrderSummaryWidget({
    super.key,
    required this.config,
    required this.cartItems,
    this.shippingFee = 5000,
    this.tax = 2000,
  });

  // Calculate subtotal dynamically
  double get subtotal {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  // Total = subtotal + shipping + tax
  double get total => subtotal + shippingFee + tax;

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary (${cartItems.length} items)",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          _summaryRow("Item Subtotal", "$subtotal MMK", isBold: true),
          const SizedBox(height: 8),

          _summaryRow("Estimated Shipping Fee", "$shippingFee MMK", isBold: true),
          const SizedBox(height: 8),

          _summaryRow("Tax", "$tax MMK", isBold: true),
          const SizedBox(height: 10),

          Divider(color: config.lineColor),

          _summaryRow("Total", "$total MMK", isBold: true),
        ],
      ),
    );
  }
}
