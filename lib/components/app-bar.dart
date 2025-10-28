import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final Widget lastIcon;
  final String? title;
  final String? imageUrl;
  final Widget? trailing;

  const CustomAppBar({
    Key? key,
    required this.leading,
    required this.lastIcon,
    this.trailing,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        shadowColor: LightModeColors.shadowColor,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left section: leading icon + title
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: leading,
                  ),
                  const SizedBox(width: 10),
                  if (title != null)
                    Text(
                      title!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                ],
              ),

              // Center section: optional logo/image
              if (imageUrl != null)
                Image.asset(
                  imageUrl!,
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),

              // Right section: trailing and last icon
              Row(
                children: [
                  if (trailing != null)
                    IconButton(
                      onPressed: () {},
                      icon: trailing!,
                    ),
                  IconButton(
                    onPressed: () {},
                    icon: lastIcon,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
