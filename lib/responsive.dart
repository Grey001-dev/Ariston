import 'package:flutter/material.dart';

class Responsive {
  static const double mobileMax = 600;
  static const double tabletMax = 1024;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  
  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= tabletMax) return 32;
    if (w >= mobileMax) return 28;
    return 20;
  }

  
  static double scale(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final clampedWidth = w.clamp(360, 430);
    return 0.92 + ((clampedWidth - 360) / (430 - 360)) * (1.0 - 0.92);
  }
}