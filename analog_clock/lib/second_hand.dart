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
      ? Color(0xFF669DF6)
      : Color(0xFF8AB4F8);

  @override double size(DateTime t)        => 1;
  @override int text(DateTime t)           => t.second;
  @override double thickness(DateTime now) => 5;

}