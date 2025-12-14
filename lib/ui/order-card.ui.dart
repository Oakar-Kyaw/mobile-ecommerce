import 'package:ecommerce_mobile/ui/circle-component.ui.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';

class OrderCard extends StatelessWidget {
  final IAppColorAbstract config;
  final bool existCheckBox;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final int quantity;
  final int? realQuantity;
  final bool isChecked;
  final void Function(int)? onQuantityChanged;
  final void Function(bool?)? onChecked;

  const OrderCard({
    super.key,
    this.existCheckBox = true,
    this.realQuantity,
    required this.config,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.isChecked = false,
    this.onQuantityChanged,
    this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if(existCheckBox)
          ShadCheckbox(
              value: isChecked,
              onChanged: onChecked,
            ),
         if(existCheckBox)
           const SizedBox(width: 10),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("${price.toString()} MMK", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 20,),
                  if(realQuantity != null) Text("( ${realQuantity.toString()} pc )")
                ],
              ),
              const SizedBox(height: 10),
              Text(brand, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // if (onQuantityChanged != null && quantity > 1) {
                      //   onQuantityChanged!(quantity - 1);
                      // }
                    },
                    child: CircleWidget(
                      colorData: config.textSecondary,
                      widgetData: const Icon(Icons.remove, size: 14),
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      // if (onQuantityChanged != null) {
                      //   onQuantityChanged!(quantity + 1);
                      // }
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
          ),
        ],
      ),
    );
  }
}
