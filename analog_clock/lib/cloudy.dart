import 'dart:math' as math;import 'package:flutter/material.dart';

class Cloudy extends StatelessWidget {

  ThemeData theme;
  DateTime time;

  Cloudy(this.theme,this.time);

  CloudyPainter _painter() => CloudyPainter(time);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _painter(),
        ),
      ),
    );
  }

}

class CloudyPainter extends CustomPainter {

  DateTime time;
  Canvas _canvas;
  Size _size;

  CloudyPainter(@required this.time);

  @override
  void paint(Canvas canvas, Size size) {
      _canvas = canvas;
      _size = size;
      _cloud1(-0.2,100);
      _cloud1( 0.0,200);
      _cloud1( 0.2,300);
      _cloud2(-0.3,150);
      _cloud2( 0.5,250);
      _cloud2( 0.3,350);
  }

  void _cloud1(double y, double speed) {
      _circle(-0.05,  0.01 + y,  0.6,  speed);
      _circle( 0.0,   0.02 + y,  0.75, speed);
      _circle( 0.07,  0.06 + y,  0.5,  speed);
  }

  void _cloud2(double y, double speed) {
    _circle(-0.04,  0.01 + y,  0.6,  speed);
    _circle(-0.08,  0.0  + y,  0.6,  speed);
    _circle( 0.09,  0.06 + y,  0.6,  speed);
    _circle( 0.06, -0.06 + y,  0.7,  speed);
  }

  void _circle(double x, double y, double r, double speed) {
    _canvas.drawCircle(_center(x,y,speed), _radius(r), _paint());
  }

  Paint _paint() => Paint()
    ..color = _color();

  Color _color() => Color(0xccFFFFFF);

  Offset _center(double x, double y, double speed) => Offset((_x(speed) + x) * _size.width, (_y() + y) * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _x(double speed) => 1.0 - _cycle(speed);
  double _y() => 1.0 - 0.5;

  double _cycle(double speed) {
      double t = _time() * speed;
      return (t - t.toInt()) * 1.4 - 0.2;
  }
  double _time() =>
      (time.hour * 3600.0 + time.minute * 60.0 + time.second + time.millisecond / 1000.0) /
          (24.0 * 60.0 * 60.0);

  @override
  bool shouldRepaint(CloudyPainter old) => true;

}