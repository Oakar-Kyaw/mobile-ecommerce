import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Avatar extends ConsumerWidget {
  final String asset; // The image asset path
  final double size; // Avatar size
  final double paddingSize;
  final VoidCallback? onTap; // Optional tap action
  final IAppColorAbstract config;

  const Avatar({
    Key? key,
    required this.asset,
    required this.config,
    this.paddingSize = 0,
    this.size = 40,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(paddingSize),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: config.background),
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
