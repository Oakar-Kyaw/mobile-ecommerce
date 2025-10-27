import 'package:flutter/material.dart';

class HorizontalScrollableList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double spacing;
  final EdgeInsets padding;

  const HorizontalScrollableList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.spacing = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: padding,
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(width: spacing),
      itemBuilder: (context, index) => itemBuilder(context, items[index], index),
    );
  }
}
