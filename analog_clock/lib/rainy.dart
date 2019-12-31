import 'package:analog_clock/time_cycle.dart';
import 'package:flutter/material.dart';
import 'ConditionalPainter.dart';

class Rainy extends ConditionalPainter {

  Rainy(theme,time,enabled) : super(theme,time,enabled);
  painter() => RainyPainter(time);

}

class RainyPainter extends CustomPainter {

  DateTime time;

  Canvas _canvas;
  Size _size;

  RainyPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
      _canvas = canvas;
      _size = size;
      _paintRain();
  }

  void _paintRain() {
      for (int i=0; i<99; i++) {
        _drop(0.01 * i,16000 + (i * i).toDouble());
      }
  }

  void _drop(double x, double speed) {
      _oval(x, 0.1, gray(0xAA), speed);
  }

  Color gray(int value) => Color.fromARGB(0xFF, value, value, value);

  void _oval(double x, double r, Color color, double speed) {
    final width = _radius(r) * 0.22;
    final height = width * 2.22;
    final rect = Rect.fromCenter(center:_center(x,speed),width: width,height:height);
    _canvas.drawOval(rect, _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double x, double speed)
    => Offset(x * _size.width, (1.0 - _y(speed)) * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _y(double speed) => TimeCycle.at(time,speed,0.0,1.4,0.2);

  @override
  bool shouldRepaint(RainyPainter old) => true;

}