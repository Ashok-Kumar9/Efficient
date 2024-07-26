import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double defaultSize;
  static late Orientation orientation;
  static late double statusBarHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    statusBarHeight = _mediaQueryData.padding.top;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.width;
  // 896 is the layout height that designer use
  return (inputHeight / 896) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.height;
  // 414 is the layout width that designer use
  return (inputWidth / 414.0) * screenWidth;
}
