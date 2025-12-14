import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final Color colorData;
  final Widget widgetData;
  final double height;
  final double width;

  const CircleWidget({
    super.key,
    required this.colorData,
    required this.widgetData,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: colorData, width: 1),
        shape: BoxShape.circle,
      ),
      child: Center(child: widgetData),
    );
  }
}
