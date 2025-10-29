import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class FixedHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final IAppColorAbstract config;
  FixedHeader({required this.child, this.height = 200, required this.config});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: config.background
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
