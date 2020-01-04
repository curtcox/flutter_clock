import 'dart:math' as math;import 'package:analog_clock/ConditionalPainter.dart';
import 'package:flutter/material.dart';

/// A sun that is drawn with [CustomPainter]
class Sun extends ConditionalPainter {

  Color _sky;

  Sun(theme,time,this._sky) : super(theme,time,true);
  painter() => SunPainter(time,_sky);

}

class SunPainter extends CustomPainter {

  DateTime _time;
  Color _sky;

  SunPainter(this._time,this._sky);

  @override
  void paint(Canvas canvas, Size size) {
    _paintSun(canvas, _rect(size), _alignment(size));
  }

  void _paintSun(Canvas canvas, Rect rect, Alignment alignment) {
    var gradient = RadialGradient(
      center: alignment,
      radius: 0.4,
      colors: [ _color(), _sky],
      stops: [0.6, 1.0],
    );
    var paint = Paint()
      ..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  Color _color() => _aroundNoon()
      ? _tween(Colors.white,Colors.yellow, _noonDistance())
      : _tween(Colors.yellow,Colors.red,   _noonDistance() - 1.0);

  bool _aroundNoon() => _noonDistance() <= 1.0;
  Color _tween(Color a, Color b, double f) =>
      Color.fromARGB(255,_mix(a.red,b.red,f),_mix(a.green,b.green,f),_mix(a.blue,b.blue,f));

  int _mix(int a, int b, double f) => (b * f + a * (1.0 - f)).toInt();

  Alignment _alignment(Size size) => Alignment(_x(),_y());
  Rect           _rect(Size size) => Rect.fromLTRB(0, 0, size.width, size.height);

  double _x() => 1.0 - _fractionOfDaytime() * 2.0;
  double _y() => 1.0 - math.sin(_fractionOfDaytime() * math.pi) * 2.0;

  double dawn = 0.25;
  double _fractionOfDaytime() => (_fractionOfDay() - dawn ) * 2.0;
  double _fractionOfDay() => (_time.hour * 60 + _time.minute) / (24 * 60);
  double _noonDistance() => _timeDistance(0.5);
  double _timeDistance(double t) => (_fractionOfDay() - t).abs() * 8.0;

  @override
  bool shouldRepaint(SunPainter old) => true;

}