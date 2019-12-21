import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'hand_function.dart';

class HourHand extends HandFunction {

  final ThemeData theme;

  /// Total distance traveled by an hour hand, each hour, in radians.
  final radiansPerHour = radians(360 / 12);

  HourHand(this.theme);

  @override double angleRadians(DateTime t) => (t.hour + t.minute / 60) * radiansPerHour;

  @override Color color(DateTime t) => theme.brightness == Brightness.light
      ? Color(0xFF4285F4)
      : Color(0xFFD2E3FC);

  @override double size(DateTime t)        => 0.5;
  @override int text(DateTime t)           => t.hour;
  @override double thickness(DateTime now) => 16;

}