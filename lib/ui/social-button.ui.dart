import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String asset;
  final IAppColorAbstract config;
  const SocialButton({
     Key? key,
    required this.asset,
    required this.config
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.all(color: config.greyColor),
      ),
      child: Image.asset(asset, fit: BoxFit.contain),
    );
  }
}