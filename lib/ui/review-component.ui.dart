import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReviewUI extends StatefulWidget {
  final List<dynamic> reviews;
  final Color starColor;
  final Color clickColor;
  final Color background;
  final Color textSecondary;

  const ReviewUI({
    super.key,
    required this.reviews,
    this.starColor = Colors.amber,
    this.clickColor = Colors.blue,
    this.background = Colors.white,
    this.textSecondary = Colors.grey,
  });

  @override
  State<ReviewUI> createState() => _ReviewUIState();
}

class _ReviewUIState extends State<ReviewUI> {
  double _starRating = 0;
  int _visibleReviews = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            children: [
              StarRating(
                rating: _starRating,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_outline,
                color: widget.starColor,
                borderColor: Colors.grey,
                onRatingChanged: (rating) => setState(() => _starRating = rating),
              ),
            ],
          ),
        ),

        // --- Input ---
        ShadInput(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          decoration: ShadDecoration(
            border: ShadBorder.all(color: widget.background),
            secondaryFocusedBorder: ShadBorder.all(color: widget.background),
          ),
          placeholder: const Text("Write a review"),
          trailing: ShadButton(
            backgroundColor: widget.clickColor,
            onPressed: () {
              print("Button pressed!");
            },
            decoration: ShadDecoration(
              border: ShadBorder.all(
                radius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),

        Divider(color: widget.textSecondary, thickness: 1),
        const SizedBox(height: 20),

        // --- ListView ---
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _visibleReviews.clamp(0, widget.reviews.length),
          itemBuilder: (context, index) {
            final review = widget.reviews[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(review.imageUrl),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StarRating(
                        mainAxisAlignment: MainAxisAlignment.start,
                        rating: review.rating,
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_outline,
                        color: widget.starColor,
                        borderColor: Colors.grey,
                        onRatingChanged: (rating) =>
                            setState(() => _starRating = rating),
                      ),
                      const SizedBox(height: 10),
                      Text(review.comment),
                      const SizedBox(height: 10),
                      Text(
                        review.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(review.date),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 15),
        ),

        // --- Load More Button ---
        if (_visibleReviews < widget.reviews.length)
          GestureDetector(
            onTap: () => setState(() {
              _visibleReviews =
                  (_visibleReviews + 3).clamp(0, widget.reviews.length);
            }),
            child: Row(
              children: const [
                Icon(Icons.refresh, size: 14, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  "Load more comments",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
