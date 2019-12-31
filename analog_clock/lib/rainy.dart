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
      double max = 501;
      for (int i=1; i<max; i++) {
        double distance = i / max;
        double x = (i + i * i) % max / max;
        _drop(x,10 + distance * 40);
      }
  }

  void _drop(double x, double distance) {
      double size = 10 / distance;
      double speed = 800000 / distance;
      _oval(x, size, gray(0xAA), speed);
  }

  Color gray(int value) => Color.fromARGB(0xAA, value, value, value);

  void _oval(double x, double r, Color color, double speed) {
    final width = _radius(r) * 0.11;
    final height = width * 2.02;
    final rect = Rect.fromCenter(center:_center(x,speed),width: width,height:height);
    _canvas.drawOval(rect, _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double x, double speed)
    => Offset(x * _size.width, (1.0 - _y(speed)) * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _y(double speed) => TimeCycle.at(time,speed,0.0,1.1,0.05);

  @override
  bool shouldRepaint(RainyPainter old) => true;

}