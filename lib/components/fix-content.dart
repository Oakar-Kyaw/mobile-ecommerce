import 'package:flutter/material.dart';

class FixedHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  FixedHeader({required this.child});

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
  double get maxExtent => 200; // adjust based on child height
  @override
  double get minExtent => 200; // same as maxExtent to keep fixed

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
