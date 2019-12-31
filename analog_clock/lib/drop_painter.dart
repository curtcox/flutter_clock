import 'package:analog_clock/time_cycle.dart';
import 'package:flutter/material.dart';

class DropPainter extends CustomPainter {

  final DateTime time;
  final Color color;
  final double speed;
  final double aspectRatio;

  Canvas _canvas;
  Size _size;

  DropPainter(this.time,this.speed,this.aspectRatio,this.color);

  @override
  void paint(Canvas canvas, Size size) {
      _canvas = canvas;
      _size = size;
      _paintDrops();
  }

  void _paintDrops() {
      double max = 501;
      for (int i=1; i<max; i++) {
        double distance = i / max;
        double x = (i + i * i) % max / max;
        _drop(x,10 + distance * 40);
      }
  }

  void _drop(double x, double distance) {
      double size = 10 / distance;
      _oval(x, size, speed / distance);
  }

  void _oval(double x, double r, double vertical) {
    final width = _radius(r) * 0.11;
    final height = width * aspectRatio;
    final rect = Rect.fromCenter(center:_center(x,vertical),width: width,height:height);
    _canvas.drawOval(rect, _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double x, double speed)
    => Offset(x * _size.width, (1.0 - _y(speed)) * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _y(double speed) => TimeCycle.at(time,speed,0.0,1.1,0.05);

  @override
  bool shouldRepaint(DropPainter old) => true;

}