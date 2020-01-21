import 'package:analog_clock/time_cycle.dart';
import 'package:flutter/material.dart';

import 'conditional_painter.dart';

class Foggy extends ConditionalPainter {
  Foggy(time, enabled) : super(time, enabled, FoggyPainter(time));
}

class FoggyPainter extends TimedCustomPainter {
  DateTime time;
  Canvas _canvas;
  Size _size;

  FoggyPainter(this.time) : super(Duration(seconds: 1));

  @override
  void custom(Canvas canvas, Size size) {
    _canvas = canvas;
    _size = size;
    _paintFog();
  }

  void _paintFog() {
    for (int i in [
      2,
      3,
      5,
      7,
      11,
      13,
      17,
      19,
      23,
      29,
      31,
      37,
      41,
      43,
      47,
      53,
      59,
      61,
      67,
      71,
      73,
      79,
      83,
      89,
      97
    ]) {
      _circle(2.7 + i / 71, gray(140 + i), i.toDouble(), i / 120);
    }
  }

  Color gray(int value) => Color.fromARGB(40, value, value, value);

  void _circle(double r, Color color, double speed, double offset) {
    _canvas.drawCircle(_center(speed, offset), _radius(r), _paint(color));
  }

  Paint _paint(Color color) => Paint()..color = color;

  Offset _center(double speed, double offset) => Offset(
      _x(speed, offset) * _size.width, 0.5 * _size.height + -191 * offset);

  double _radius(double r) => (r * _size.height) / 5;

  double _x(double speed, double offset) =>
      TimeCycle.at(time, speed, offset, 1.8, 0.4);
}
