import 'package:analog_clock/time_cycle.dart';
import 'package:flutter/material.dart';

class Cloudy extends StatelessWidget {

  final ThemeData theme;
  final DateTime time;
  final bool cloudy;

  Cloudy(this.theme,this.time,this.cloudy);

  CloudyPainter _painter() => CloudyPainter(time,cloudy);

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
  bool cloudy;
  Canvas _canvas;
  Size _size;

  CloudyPainter(@required this.time,this.cloudy);

  @override
  void paint(Canvas canvas, Size size) {
      if (!cloudy) {
          return;
      }
      _canvas = canvas;
      _size = size;
      _paintClouds();
  }

  void _paintClouds() {
      _cloud1(0.0,101);
      _cloud2(0.1,203);
      _cloud3(0.2,307);
      _cloud1(0.3,151);
      _cloud2(0.4,252);
      _cloud3(0.5,357);
      _cloud1(0.6,057);
      _cloud2(0.7,177);
      _cloud3(0.8,277);
      _cloud1(0.9,127);
      _cloud2(1.0,147);
  }

  void _cloud1(double y, double speed) {
      _circle(-0.05,  0.01 + y,  0.6,  gray(0xFF), speed);
      _circle( 0.0,   0.02 + y,  0.75, gray(0xEE), speed);
      _circle( 0.07,  0.06 + y,  0.5,  gray(0xF8), speed);
  }

  void _cloud2(double y, double speed) {
    _circle(-0.04,  0.01 + y,  0.6,  gray(0xFF), speed);
    _circle(-0.08,  0.0  + y,  0.6,  gray(0xEE), speed);
    _circle( 0.09,  0.06 + y,  0.6,  gray(0xF8), speed);
    _circle( 0.06, -0.06 + y,  0.7,  gray(0xFB), speed);
  }

  void _cloud3(double y, double speed) {
    _circle(-0.04,  0.02 + y,  0.55,  gray(0xFF), speed);
    _circle(-0.08, -0.0  + y,  0.65,  gray(0xEE), speed);
    _circle( 0.08,  0.06 + y,  0.6,   gray(0xF8), speed);
    _circle( 0.06, -0.04 + y,  0.44,  gray(0xFB), speed);
    _circle(-0.06, -0.06 + y,  0.68,  gray(0xF4), speed);
  }

  Color gray(int value) => Color.fromARGB(0xCC, value, value, value);

  void _circle(double x, double y, double r, Color color, double speed) {
    _canvas.drawCircle(_center(x,y,speed), _radius(r), _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double x, double y, double speed)
    => Offset((_x(speed) + x) * _size.width,  y * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _x(double speed) => TimeCycle.at(time,speed,0.0,1.4,0.2);

  @override
  bool shouldRepaint(CloudyPainter old) => true;

}