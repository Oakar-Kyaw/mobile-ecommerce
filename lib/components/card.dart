import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final String? description;
  final bool isFavorite;

  const ProductCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    this.description,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🖼️ Image with favorite icon overlay
        Stack(
          children: [
            SizedBox(
              width: 150,
              height: 200,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
             Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4), // space around the icon
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // background color
                    shape: BoxShape.circle,   // make it circular
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                    size: 18,
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: 8),

        // 🧱 Product info card
        ShadCard(
          rowCrossAxisAlignment: CrossAxisAlignment.start,
          columnMainAxisAlignment: MainAxisAlignment.start,
          width: 150,
          padding: const EdgeInsets.all(8),
          border: ShadBorder.none,
          shadows: const [
            BoxShadow(color: Colors.transparent),
          ],
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Trim long titles
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          description: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              description ?? "No description",
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Trim long descriptions
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
          footer: Text(
            price,
            style: const TextStyle(
             // color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
