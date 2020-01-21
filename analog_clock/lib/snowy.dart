import 'package:flutter/material.dart';
import 'conditional_painter.dart';
import 'drop_painter.dart';

class Snowy extends ConditionalPainter {
  Snowy(time, enabled)
      : super(
            time,
            enabled,
            DropPainter(
                time, 70000, 1.0, _gray(0xFF), Duration(milliseconds: 100)));

  static Color _gray(int value) => Color.fromARGB(0xFF, value, value, value);
}
