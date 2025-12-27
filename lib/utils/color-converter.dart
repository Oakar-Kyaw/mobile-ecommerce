import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  // If short format like "#FFF", expand to "#FFFFFF"
  String formatted = hex.replaceAll("#", "");
  if (formatted.length == 3) {
    formatted = formatted.split('').map((c) => '$c$c').join();
  }
  if (formatted.length == 4) { // your #FFFF
    formatted = formatted.substring(0, 3).split('').map((c) => '$c$c').join();
  }
  return Color(int.parse("0xFF$formatted"));
}
