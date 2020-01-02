import 'dart:math' as math;import 'package:analog_clock/ConditionalPainter.dart';
import 'package:flutter/material.dart';

/// A sun that is drawn with [CustomPainter]
class Sun extends ConditionalPainter {

  Sun(theme,time) : super(theme,time,true);
  painter() => SunPainter(time);

}

class SunPainter extends CustomPainter {

  DateTime time;

  SunPainter(@required this.time);

  @override
  void paint(Canvas canvas, Size size) {
      canvas.drawCircle(_center(size), _radius(size), _paint());
  }

  Paint _paint() => Paint()
    ..color = _color();

  Color _color() => _aroundNoon()
      ? _tween(Colors.white,Colors.yellow, _noonDistance())
      : _tween(Colors.yellow,Colors.red,   _noonDistance() - 1.0);

  bool _aroundNoon() => _noonDistance() <= 1.0;
  Color _tween(Color a, Color b, double f) =>
      Color.fromARGB(255,_mix(a.red,b.red,f),_mix(a.green,b.green,f),_mix(a.blue,b.blue,f));

  int _mix(int a, int b, double f) => (b * f + a * (1.0 - f)).toInt();

  Offset _center(Size size) => Offset(_x() * size.width,_y() * size.height);

  double _radius(Size size) => size.height/5;

  double _x() => 1.0 - _fractionOfDaytime();
  double _y() => 1.0 - math.sin(_fractionOfDaytime() * math.pi);

  double dawn = 0.25;
  double _fractionOfDaytime() => (_fractionOfDay() - dawn ) * 2.0;
  double _fractionOfDay() => (time.hour * 60 + time.minute) / (24 * 60);
  double _noonDistance() => _timeDistance(0.5);
  double _timeDistance(double t) => (_fractionOfDay() - t).abs() * 8.0;

  @override
  bool shouldRepaint(SunPainter old) => true;

}