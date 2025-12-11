import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example order items
    final orders = [
      {"name": "Product A", "price": 25.0, "quantity": 2},
      {"name": "Product B", "price": 15.0, "quantity": 1},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text("${order["name"]}"),
              subtitle: Text("Quantity: ${order["quantity"]}"),
            ),
          );
        },
      ),
    );
  }
}

extension on Object {
  void operator *(Object? other) {}
}
