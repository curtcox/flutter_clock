import 'dart:ui';

class Bounds {
  static const double overscan = 122.0;
  static const left = -overscan;

  static Rect rect(Size size) => Rect.fromLTRB(
      -overscan, -overscan, size.width + overscan, size.height + overscan);
}
