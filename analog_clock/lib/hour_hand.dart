import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:intl/intl.dart';

import 'hand.dart';
import 'hand_function.dart';
import 'hand_painter.dart';
import 'hand_part.dart';

class HourHand extends HandFunction {

  final ThemeData theme;
  final ClockModel model;

  /// Total distance traveled by an hour hand, each hour, in radians.
  final radiansPerHour = radians(360 / 12);

  HourHand(this.theme,this.model);

  @override double angleRadians(DateTime t) => (t.hour + t.minute / 60) * radiansPerHour;

  @override Color color(DateTime t) => theme.brightness == Brightness.light
      ? Colors.green
      : Colors.lightGreenAccent;

  @override double size(DateTime t)        => 0.5;
  @override int  number(DateTime t)        => _hour(t);
  @override double thickness(DateTime now) => 16;

  _hour(DateTime t) => int.parse(DateFormat(model.is24HourFormat ? 'HH' : 'hh').format(t));

  static Hand hand(ThemeData theme,ClockModel model,DateTime time,Duration duration, HandPart part) =>
      Hand(time,HandPainter(HourHand(theme,model),time,duration,part));

}