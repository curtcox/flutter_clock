import 'package:flutter/material.dart';

abstract class HandFunction {

  /// Hand color.
  Color color(DateTime t);

  /// Hand length, as a percentage of the smaller side of the clock's parent container.
  double size(DateTime t);

  /// How thick the hand should be drawn, in logical pixels.
  double thickness(DateTime now);

  /// The angle, in radians, at which the hand is drawn.
  ///
  /// This angle is measured from the 12 o'clock position.
  double angleRadians(DateTime t);

  /// text to display on/for the hand
  String text(DateTime t) => number(t).toString();

  /// value of time for the hand
  int number(DateTime t);

}
