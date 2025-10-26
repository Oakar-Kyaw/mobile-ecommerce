import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String asset; // The image asset path
  final double size; // Avatar size
  final double paddingSize;
  final VoidCallback? onTap; // Optional tap action

  const Avatar({
    Key? key,
    required this.asset,
    this.paddingSize = 0,
    this.size = 40,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(paddingSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: const Color(0xFFdbd5d7)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
          ), // cover ensures it fills
        ),
      ),
    );
  }
}
