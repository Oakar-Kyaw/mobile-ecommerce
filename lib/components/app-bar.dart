import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  // final PreferredSizeWidget? bottom;

  const CustomAppBar({
    Key? key,
    required this.title,
    // this.bottom,
  }) : super(key: key);

  // @override
  // Size get preferredSize =>
  //     Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return  PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Top row: menu, logo, icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                      tooltip: 'Menu',
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      width: 50,
                      height: 50,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shopping_cart),
                          tooltip: 'Cart',
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.message_sharp),
                          tooltip: 'Messages',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
      ;
  }
}