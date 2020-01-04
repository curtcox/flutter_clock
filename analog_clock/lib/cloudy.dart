import 'package:analog_clock/time_cycle.dart';
import 'package:flutter/material.dart';
import 'ConditionalPainter.dart';

class Cloudy extends ConditionalPainter {

  final int _darkness;

  Cloudy(theme,time,this._darkness,enabled) : super(theme,time,enabled);
  painter() => CloudyPainter(time,_darkness);

}

class CloudyPainter extends CustomPainter {

  DateTime _time;
  Canvas _canvas;
  Size _size;
  int _darkness;

  CloudyPainter(this._time,this._darkness);

  @override
  void paint(Canvas canvas, Size size) {
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
      _oval(-0.05,  0.01 + y,  0.6,  _gray(0xFF), speed);
      _oval( 0.0,   0.02 + y,  0.75, _gray(0xEE), speed);
      _oval( 0.07,  0.06 + y,  0.5,  _gray(0xF8), speed);
  }

  void _cloud2(double y, double speed) {
    _oval(-0.04,  0.01 + y,  0.6,  _gray(0xFF), speed);
    _oval(-0.08,  0.0  + y,  0.6,  _gray(0xEE), speed);
    _oval( 0.09,  0.06 + y,  0.6,  _gray(0xF8), speed);
    _oval( 0.06, -0.06 + y,  0.7,  _gray(0xFB), speed);
  }

  void _cloud3(double y, double speed) {
    _oval(-0.04,  0.02 + y,  0.55,  _gray(0xFF), speed);
    _oval(-0.08, -0.0  + y,  0.65,  _gray(0xEE), speed);
    _oval( 0.08,  0.06 + y,  0.6,   _gray(0xF8), speed);
    _oval( 0.06, -0.04 + y,  0.44,  _gray(0xFB), speed);
    _oval(-0.06, -0.06 + y,  0.68,  _gray(0xF4), speed);
  }

  Color _gray(int value) => _grayShade(value - _darkness);
  Color _grayShade(int value) => Color.fromARGB(0xCC, value, value, value);

  void _oval(double x, double y, double r, Color color, double speed) {
    final width = _radius(r) * 2.22;
    final height = width * 0.62;
    final rect = Rect.fromCenter(center:_center(x,y,speed),width: width,height:height);
    _canvas.drawOval(rect, _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double x, double y, double speed)
    => Offset((_x(speed) + x) * _size.width,  y * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _x(double speed) => TimeCycle.at(_time,speed,0.0,1.4,0.2);

  @override
  bool shouldRepaint(CloudyPainter old) => true;

}