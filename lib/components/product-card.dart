import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final num price;
  final String currency;
  final num? discountPrice;
  final String imageUrl;
  final String? description;
  final bool isFavorite;

  const ProductCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.currency = "MMK",
    this.description,
    this.discountPrice,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 180,
              height: 185,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
             Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6), // space around the icon
                  decoration: BoxDecoration(
                    color: LightModeColors.favoriteIconBackground, // background color
                    shape: BoxShape.circle,   // make it circular
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? LightModeColors.error : LightModeColors.primary,
                    size: 18,
                  ),
                ),
              ),
              // The promotion badge
            if(discountPrice != null) Positioned(
              top: 15,
              left: -30,
              child: Transform.rotate(
                angle: -0.785398, // -45 degrees in radians
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 30),
                  color: LightModeColors.secondary,
                  child: Text(
                    '10% OFF',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        //const SizedBox(height: 2),

        // 🧱 Product info card
        ShadCard(
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          columnMainAxisAlignment: MainAxisAlignment.start,
          width: 170,
          padding: const EdgeInsets.all(8),
          border: ShadBorder.none,
          radius: BorderRadius.zero,
          shadows: const [
            BoxShadow(color: Colors.transparent),
          ],
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Trim long titles
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          description: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              description ?? "No description",
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Trim long descriptions
              style: const TextStyle(fontSize: 13, color: LightModeColors.textSecondary),
            ),
          ),
          footer: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (discountPrice != null)
                Text(
                  "${NumberFormat('#,###').format(discountPrice)} $currency",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),
                ),  
              Text(
                "${NumberFormat('#,###').format(price)} $currency",
                style: TextStyle(
                  fontSize: 14,
                  decoration: discountPrice != null ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
