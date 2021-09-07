import 'package:flutter/material.dart';
class ScreenSize {
  ScreenSize({required this.context});
  BuildContext context;
  double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = MediaQuery.of(context).size.height;
  return (inputHeight / 812.0) * screenHeight;
}
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (inputWidth / 375.0) * screenWidth;
}
}