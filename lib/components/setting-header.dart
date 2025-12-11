import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingHeader extends ConsumerWidget {
  const SettingHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipPath(
      clipper: SoftBottomCurveClipper(), 
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 244, 225, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Hello, Welcome to Shop!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadButton.outline(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: const ShadDecoration(
                    border: ShadBorder(
                      radius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  backgroundColor: Color.fromRGBO(240, 240, 240, 1),
                  child: const Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoute.login);
                  },
                ),
                const SizedBox(width: 10),
                ShadButton.outline(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: const ShadDecoration(
                    border: ShadBorder(
                      radius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  backgroundColor: Colors.black,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 👇 This creates a soft, modern curved bottom edge
class SoftBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 70); // less curve depth
    path.quadraticBezierTo(
      size.width / 2, size.height + 70, // gentle control point
      size.width, size.height - 70,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
