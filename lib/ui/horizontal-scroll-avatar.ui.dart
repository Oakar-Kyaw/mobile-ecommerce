import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class HorizontalScrollableBrand extends StatelessWidget {
  final List<Map<String, dynamic>> brands;
  final void Function(int)? onTap;
  final bool isCheckBorderRadius; // new flag

  const HorizontalScrollableBrand({
    super.key,
    required this.brands,
    this.onTap,
    this.isCheckBorderRadius = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80, // enough space for image + title
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        itemCount: brands.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final brand = brands[index];
          final imageUrl = brand['imageUrl'];
          final title = brand['title'];

          return GestureDetector(
            onTap: () => onTap?.call(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                 // padding: const EdgeInsets.all(2), // space for border
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isCheckBorderRadius
                        ? Border.all(color: LightModeColors.textSecondary, width: 0.5)
                        : null,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(imageUrl),
                    backgroundColor: LightModeColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60, // limit width for long brand names
                  child: Text(
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
