import 'package:flutter/material.dart';

class ColorGenerator {
  static Color _indexToColor(int index, int totalColors) {
    final hue = (index / totalColors) * 360;
    return HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }

  static List<Color> generateColorList(int totalColors) {
    return List<Color>.generate(
      totalColors,
      (index) => _indexToColor(index, totalColors),
    ).reversed.toList();
  }
}
