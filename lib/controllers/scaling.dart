import "dart:math";
import "package:flutter/material.dart";

// this should control text scaling
// https://stackoverflow.com/questions/57210428/how-to-create-responsive-text-widget-in-flutter

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 5}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
