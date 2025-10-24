import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SwiperCard extends StatelessWidget {
  final double height;

  const SwiperCard({super.key, this.height = 200}); // default height

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // set the height you want
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset("assets/images/shirt.jpg", fit: BoxFit.cover);
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }
}
