import 'package:flutter/material.dart';

class Styles {
  static const Color lightGreen = Color(0XFF64DD17);
  static const Color obscureGreen = Color(0xff008E69);
  static const titleStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w500);
  static const subtitleStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  static LinearGradient getColorGradient(Color color) {
    var baseColor = color as dynamic;
    Color color1 = baseColor[800];
    Color color2 = baseColor[400];
    return LinearGradient(colors: [
      color1,
      color2,
    ], begin: Alignment.bottomLeft, end: Alignment.topRight);
  }
}
