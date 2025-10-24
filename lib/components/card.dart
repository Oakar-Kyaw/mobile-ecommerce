import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final double? price;
  final VoidCallback? onTap;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final BorderRadiusGeometry borderRadius;

  const ProductCard({
    Key? key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.price,
    this.onTap,
    this.trailing,
    this.padding = const EdgeInsets.all(12),
    this.elevation = 2,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                //   color: colorScheme.muted.withOpacity(0.2),
                child: const Center(
                  child: Icon(LucideIcons.image, size: 48, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text("Product 1", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            "\$${(20 + 1 * 5)}.00",
            style: TextStyle(
              //    color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          ShadButton(
            size: ShadButtonSize.sm,
            onPressed: () => print("Add Product 1"),
            child: const Text("Add to Cart"),
          ),
        ],
      ),
    );
  }
}
