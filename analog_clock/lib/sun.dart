import 'dart:math' as math;import 'package:analog_clock/ConditionalPainter.dart';
import 'package:flutter/material.dart';

/// A sun that is drawn with [CustomPainter]
class Sun extends ConditionalPainter {

  final Color _sky;

  Sun(theme,time,this._sky) : super(theme,time,true);
  painter() => SunPainter(time,_sky, Duration(seconds: 100));

}

class SunPainter extends TimedCustomPainter {

  DateTime _time;
  Color _sky;

  SunPainter(this._time,this._sky,rate) : super(rate);

  @override
  void custom(Canvas canvas, Size size) {
    _paintSky(canvas,size);
    _paintSun(canvas, _rect(size), _alignment(size));
  }

  void _paintSky(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _sky;
    canvas.drawRect(_rect(size), paint);
  }

  final x = 122.0;
  Rect _rect(Size size) => Rect.fromLTRB(-x, -x, size.width + x, size.height + x);

  void _paintSun(Canvas canvas, Rect rect, Alignment alignment) {
    final gradient = RadialGradient(
      center: alignment,
      radius: 0.33,
      colors: [ _color(), _sky],
      stops: [0.65, 1.0],
    );
    final paint = Paint()
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

  double _x() => 1.0 - _fractionOfDaytime() * 2.0;
  double _y() => 1.0 - math.sin(_fractionOfDaytime() * math.pi) * 2.0;

  double dawn = 0.25;
  double _fractionOfDaytime() => (_fractionOfDay() - dawn ) * 2.0;
  double _fractionOfDay() => (_time.hour * 60 + _time.minute) / (24 * 60);
  double _noonDistance() => _timeDistance(0.5);
  double _timeDistance(double t) => (_fractionOfDay() - t).abs() * 8.0;

}