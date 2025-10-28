import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isExistedIcon;

  const TitleWidget(
    this.text, {
    Key? key,
    this.onTap,
    this.isExistedIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (isExistedIcon)
                    IconButton(
                      onPressed: onTap,
                      icon: const Icon(Icons.arrow_forward, color: LightModeColors.primary,),
                      tooltip: 'Arrow Forward',
                    ),
                ],
              ),
            );
  }
}