import 'package:ecommerce_mobile/riverpod/checkout-order-calculation.dart';
import 'package:ecommerce_mobile/ui/circle-component.ui.dart';
import 'package:ecommerce_mobile/utils/color-converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';

class OrderCard extends ConsumerWidget {
  final IAppColorAbstract config;
  final bool existCheckBox;
  final bool existColorField;
  final bool existSizeField;
  final bool existQuantityButton;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final int quantity;
  final String currency;
  final int? realQuantity;
  final String? size;
  final String? color;
  final bool isChecked;
  final void Function(int)? onQuantityChanged;
  final void Function(bool?)? onChecked;

  const OrderCard({
    super.key,
    this.existCheckBox = true,
    this.existColorField = false,
    this.existSizeField = false,
    this.existQuantityButton = true,
    this.realQuantity,
    required this.config,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.currency,
    this.quantity = 1,
    this.size,
    this.color,
    this.isChecked = false,
    this.onQuantityChanged,
    this.onChecked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderTotals = ref.read(checkOutOrderCalculationDataProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ✅ Checkbox
          if (existCheckBox)
            ShadCheckbox(
              value: isChecked,
              onChanged: (value) {
                if (onChecked != null) {
                  onChecked!(value);
                }
              },
            ),

          if (existCheckBox) const SizedBox(width: 10),

          /// ✅ Image
          Container(
            height: 120,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// ✅ Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(height: 5),

              Row(
                children: [
                  Text(
                    "$price $currency",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (realQuantity != null) ...[
                    const SizedBox(width: 10),
                    Text("( $realQuantity pc )"),
                  ],
                ],
              ),

              const SizedBox(height: 5),
              Text(brand, style: const TextStyle(fontSize: 12)),

              if (existColorField && color != null) ...[
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text("Color: "),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: hexToColor(color!), // converts your hex string like "#FFFF"
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color.fromARGB(255, 196, 196, 196), width: 1), // optional border
                        ),
                      ),
                    ],
                  ),
                ],

              if (existSizeField && size != null) ...[
                const SizedBox(height: 5),
                Text("Size: $size"),
              ],

              /// ✅ Quantity Buttons
              if (existQuantityButton) ...[
                const SizedBox(height: 5),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (onQuantityChanged != null && quantity > 0) {
                          onQuantityChanged!(quantity - 1);
                        }
                      },
                      child: CircleWidget(
                        colorData: config.textSecondary,
                        widgetData: const Icon(Icons.remove, size: 14),
                        height: 20,
                        width: 20,
                      ),
                    ),

                    const SizedBox(width: 15),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 15),

                    GestureDetector(
                      onTap: () {
                        if (onQuantityChanged != null) {
                          onQuantityChanged!(quantity + 1);                          
                        }
                      },
                      child: CircleWidget(
                        colorData: config.textSecondary,
                        widgetData: const Icon(Icons.add, size: 14),
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
