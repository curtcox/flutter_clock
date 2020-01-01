import 'package:analog_clock/time_cycle.dart';
import 'package:flutter/material.dart';
import 'ConditionalPainter.dart';

class Thunderstorm extends ConditionalPainter {

  Thunderstorm(theme,time,enabled) : super(theme,time,enabled);
  painter() => ThunderstormPainter(time);

}

class ThunderstormPainter extends CustomPainter {

  DateTime time;

  Canvas _canvas;
  Size _size;

  ThunderstormPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
      if (_shouldFlash()) {
        _canvas = canvas;
        _size = size;
        _paintFlash();
        _paintLightning();
      }
  }

  bool _shouldFlash() => time.second % 2 == 1 && time.millisecond < 100;

  void _paintFlash() {
    _canvas.drawRect(_all(), _paint(gray(255)));
  }

  Rect _all() => Rect.fromLTRB(0, 0, _size.width, _size.height);

  void _paintLightning() {
  }

  Color gray(int value) => Color.fromARGB(0xCC, value, value, value);

  Paint _paint(Color color) => Paint()
    ..color = color;

  @override
  bool shouldRepaint(ThunderstormPainter old) => true;

}