import 'dart:ui';

import 'package:analog_clock/hand_painter.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'hand.dart';
import 'hand_function.dart';
import 'hand_part.dart';

class MinuteHand extends HandFunction {
  final ThemeData theme;

  /// Total distance traveled by a second or a minute hand, each second or minute,
  /// respectively.
  final radiansPerTick = radians(360 / 60);

  MinuteHand(this.theme);

  @override
  double angleRadians(DateTime t) =>
      (t.minute + t.second / 60) * radiansPerTick;

  @override
  Color color(DateTime t) => theme.brightness == Brightness.light
      ? Colors.blue
      : Colors.lightBlueAccent;

  @override
  double size(DateTime t) => 0.9;
  @override
  int number(DateTime t) => t.minute;
  @override
  double thickness(DateTime t) => 16;

  static Hand hand(
          ThemeData theme, DateTime time, Duration duration, HandPart part) =>
      Hand(time, HandPainter(MinuteHand(theme), time, duration, part));
}
