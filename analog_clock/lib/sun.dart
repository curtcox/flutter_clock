import 'dart:math' as math;import 'package:analog_clock/ConditionalPainter.dart';
import 'package:flutter/material.dart';

/// Sun and sky that is drawn with [CustomPainter]
class Sun extends ConditionalPainter {

  final bool _storm;
  final bool _light;

  Sun(theme,time,this._storm,this._light) : super(theme,time,true);
  painter() => SunPainter(time,_storm,_light,Duration(seconds: 30));

}

class SunPainter extends TimedCustomPainter {

  DateTime _time;
  bool _storm;
  bool _lightTheme;
  static const Color _clear = Color.fromARGB(0, 0, 0, 0);

  SunPainter(this._time,this._storm,this._lightTheme,rate) : super(rate);

  @override
  void custom(Canvas canvas, Size size) {
    _paintSunlight(canvas, _rect(size), _alignment(size));
    _paintSun(canvas, _rect(size), _alignment(size));
  }

  final x = 122.0;
  Rect _rect(Size size) => Rect.fromLTRB(-x, -x, size.width + x, size.height + x);

  void _paintSun(Canvas canvas, Rect rect, Alignment alignment) {
    final gradient = RadialGradient(
      center: alignment,
      radius: 0.15,
      colors: [ _sun(), _clear],
      stops: [0.999, 1.0],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  void _paintSunlight(Canvas canvas, Rect rect, Alignment alignment) {
    final gradient = RadialGradient(
      center: alignment,
      radius: 1.5,
      colors: [ _sun(), _sky1(), _sky2(), _sky3()],
      stops: [0.0, 0.1, 0.5, 1.0],
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  static const Color _white        = Color(0xFFFFFFFF);
  static const Color _yellow       = Color(0xFFFFF9C4);
  static const Color _sunRed       = Color(0xFFFFAAAA);
  static const Color _coronaRed    = Color(0xFFFF0000);
  static const Color _coronaYellow = Color(0xFFFFEE58);
  static const Color _sunnySky     = Color(0xFFA8DDFF);
  static const Color _stormySky    = Color(0xFF88AACC);
  static const Color _night        = Color(0xFF000000);

  static const Color _darkWhite  = Color(0xFF808080);
  static const Color _darkSky    = Color(0xFF546F80);
  static const Color _darkRed    = Color(0xFF800000);
  static const Color _darkYellow = Color(0xFF80772D);

  Color _sun()  => _dayTween(_white,_yellow,_sunRed,_sunRed);
  Color _sky1() => _dayTween(_noonCorona(),_daytimeCorona(),_twilightCorona(),_night);
  Color _sky2() => _dayTween(_baseSkyColor(),_daytimeCorona(),_twilightCorona(),_night);
  Color _sky3() => _dayTween(_baseSkyColor(), _baseSkyColor(), _twilightCorona(), _night);
  Color _baseSkyColor()   => _lightTheme ? _lightSky() : _darkSky;
  Color _lightSky()       => _storm ? _stormySky : _sunnySky;
  Color _noonCorona()     => _lightTheme ? _white : _darkWhite;
  Color _daytimeCorona()  => _lightTheme ? _coronaYellow : _darkYellow;
  Color _twilightCorona() => _lightTheme ? _coronaRed : _darkRed;

  bool _aroundNoon() => _noonDistance() <= 1.0;
  Color _dayTween(Color noon, Color morning, Color dawn, Color midnight) {
      if (_aroundNoon()) { return _tween(noon,morning,_noonDistance()); }
      if (_daylight())   { return _tween(morning,dawn,_twilightDistance()); }
      return _tween(midnight,dawn,_midnightDistance());
  }
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
  bool _daylight() => _time.hour >= 6 && _time.hour < 18;
  double _twilightDistance() => _noonDistance() - 1.0;
  double _midnightDistance() {
    final f = _fractionOfDay();
    if (f < 0.25) return f * 4;
    if (f > 0.75) return (1.0 - f) * 4;
    if (f > 0.25) return 1;
    return 0;
  }
  double _timeDistance(double t) => (_fractionOfDay() - t).abs() * 8.0;

}