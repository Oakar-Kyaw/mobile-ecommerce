import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SwiperCard extends ConsumerWidget {
  final double height;

  const SwiperCard({super.key, this.height = 300});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return SizedBox(
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 🖼 Background image
                Image.asset(
                  "assets/images/shirt.jpg",
                  fit: BoxFit.cover,
                ),

                // 🌫 Optional overlay to make text readable
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 129, 127, 127).withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),

                // 📝 Text & button — vertically centered, left aligned
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          "40–50% OFF",
                          style: TextStyle(
                            color: config.background,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Now in Shirts",
                          style: TextStyle(
                            color: config.background,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "All Colours",
                          style: TextStyle(
                            color: config.background,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ShadButton.outline(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.promotion);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Shop Now",
                                style: TextStyle(
                                  color: config.background,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward, color: config.background)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 3,

        // ✅ Pagination dots
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(bottom: 0),
          builder: DotSwiperPaginationBuilder(
            color: config.textSecondary,
            activeColor: config.textPrimary,
            size: 8.0,
            activeSize: 10.0,
          ),
        ),

        // ❌ No arrows
        control: null,
      ),
    );
  }
}
