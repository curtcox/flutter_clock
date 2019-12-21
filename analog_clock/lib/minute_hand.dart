import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'hand_function.dart';

class MinuteHand extends HandFunction {

  final ThemeData theme;

  /// Total distance traveled by a second or a minute hand, each second or minute,
  /// respectively.
  final radiansPerTick = radians(360 / 60);

  MinuteHand(this.theme);

  @override double angleRadians(DateTime t) => (t.minute + t.second / 60) * radiansPerTick;

  @override Color color(DateTime t) => theme.brightness == Brightness.light
      ? Colors.blue
      : Colors.blue;

  @override double size(DateTime t)        => 0.9;
  @override int text(DateTime t)           => t.minute;
  @override double thickness(DateTime now) => 16;

}