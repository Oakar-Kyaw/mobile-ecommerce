import 'package:flutter/material.dart';

class FixedHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  FixedHeader({required this.child, this.height = 200});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
    //  padding: const EdgeInsets.only(bottom: 5),
      child: child,
    );
  }

  @override
  double get maxExtent => height; // adjust based on child height
  @override
  double get minExtent => height; // same as maxExtent to keep fixed

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
