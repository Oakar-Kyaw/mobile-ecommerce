// lib/components/divider.dart
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class DoubleLineTriangleDivider extends StatelessWidget {
  final Color color;
  final double thickness;
  final double triangleSize;
  final double gap;
  final MainAxisAlignment alignment;
  final EdgeInsetsGeometry? padding;

  const DoubleLineTriangleDivider({
    Key? key,
    this.color = LightModeColors.textSecondary,
    this.thickness = 1,
    this.triangleSize = 10,
    this.gap = 0,
    this.alignment = MainAxisAlignment.center,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Total height should accommodate the triangle and line thickness.
    final height = triangleSize.clamp(thickness, double.infinity);

    Widget line = Container(height: thickness, color: color);

    Widget triangle = SizedBox(
      width: triangleSize,
      height: triangleSize,
      child: CustomPaint(
        painter: _DoubleTrianglePainter(color: color, gap: 0),
      ),
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: alignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 75,child: line),
            SizedBox(width: gap),
            triangle,
            SizedBox(width: gap),
            SizedBox(width: 75,child: line),
          ],
        ),
      ),
    );
  }
}

class _DoubleTrianglePainter extends CustomPainter {
  final Color color;
  final double gap; // the transparent gap in the middle

  _DoubleTrianglePainter({required this.color, this.gap = 4});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Top triangle (pointing up)
    final topPath = Path()
      ..moveTo(0, size.height / 2 - gap / 2) // bottom-left of top triangle
      ..lineTo(size.width / 2, 0) // top-center (apex)
      ..lineTo(size.width, size.height / 2 - gap / 2) // bottom-right of top triangle
      ..close();

    canvas.drawPath(topPath, paint);

    // Bottom triangle (pointing down)
    final bottomPath = Path()
      ..moveTo(0, size.height / 2 + gap / 2) // top-left of bottom triangle
      ..lineTo(size.width / 2, size.height) // bottom-center (apex)
      ..lineTo(size.width, size.height / 2 + gap / 2) // top-right of bottom triangle
      ..close();

    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DoubleTrianglePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.gap != gap;
  }
}
