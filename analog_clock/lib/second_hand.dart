import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'hand_function.dart';

class SecondHand extends HandFunction {

  final ThemeData theme;

  /// Total distance traveled by a second or a minute hand, each second or minute,
  /// respectively.
  final radiansPerTick = radians(360 / 60);

  SecondHand(this.theme);

  @override double angleRadians(DateTime t) => (t.second + t.millisecond / 1000) * radiansPerTick;

  @override Color color(DateTime t) => theme.brightness == Brightness.light
      ? Colors.red
      : Colors.red;

  @override double      size(DateTime t) => 1;
  @override int       number(DateTime t) => t.second;
  @override String      text(DateTime t) => "";
  @override double thickness(DateTime t) => 5;

}