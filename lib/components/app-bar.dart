import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leading;
  final IconData lastIcon;
  final String? title;
  final String? imageUrl;
  final IconData? trailing;

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
        shadowColor: Color.fromRGBO(106, 103, 103, 0.3),
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
                    icon: Icon(leading),
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
                      icon: Icon(trailing),
                    ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(lastIcon),
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
