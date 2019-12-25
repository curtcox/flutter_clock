import 'dart:math' as math;import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class Thermometer extends StatelessWidget {

  ThemeData theme;
  num current;
  num low;
  num high;
  TemperatureUnit unit;

  Thermometer(this.theme,this.unit,this.current,this.low,this.high);

  ThermometerPainter _painter() => ThermometerPainter(unit,current,low,high);

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

class ThermometerPainter extends CustomPainter {

  num current;
  num low;
  num high;
  TemperatureUnit unit;

  double _w;
  double _h;
  Canvas _canvas;

  ThermometerPainter(this.unit,this.current,this.low,this.high);

  @override
  void paint(Canvas canvas, Size size) {
      _w      = size.width;
      _h      = size.height;
      _canvas = canvas;
      _bulb(7.5,_black());
      _tube(_edge(),    _black());
      _tube(_inner(),   _glass());
      _bulb(7,_red());
      _tube(_tempBar(),   _red());
      _tube(_center(), _darker());
      _bulb(2,_darker());
      _low();
      _high();
      _current();
  }

  _low()     { _mark(low);}
  _high()    { _mark(high); }
  _current() { _mark(current); }

  num _celsius(num degrees) {
    switch (unit) {
      case TemperatureUnit.fahrenheit:
        return (degrees - 32.0) * 5.0 / 9.0;
      case TemperatureUnit.celsius:
      default:
        return degrees;
        break;
    }
  }

  double _cy(num temp) => _h - ((_celsius(temp) + 40.0) * (_h / 100.0));

  void _tube(Rect rect, Paint paint) { _canvas.drawRect(rect, paint); }
  void _bulb(double r,  Paint paint) { _canvas.drawOval(_oval(r), paint); }
  void _mark(num temp)                  {
    final c = _cy(temp);
    _canvas.drawRect(_ltrb(_w - 10,c + 0.5,_w,c - 0.5), _black());
  }

  Rect    _edge() => _ltrb(_w - 5.5,            0,   _w,     _h);
  Rect   _inner() => _ltrb(_w - 5.0,            0,   _w,     _h);
  Rect  _center() => _ltrb(_w - 2.5,            0,   _w - 2, _h);
  Rect _tempBar() => _ltrb(_w - 3.0, _cy(current),   _w - 1, _h);
  Rect _oval(double r) => _ltrb(_w - r -2.5, _h - r, _w + r - 2.5, _h + r);
  Rect _ltrb(double l,double t,double r,double b) => Rect.fromLTRB(l,t,r,b);

  Paint  _white() => _paint(Colors.white);
  Paint    _red() => _paint(Colors.red);
  Paint  _black() => _paint(Colors.black);
  Paint  _glass() => _paint(Color(0xFFeeeeee));
  Paint _darker() => _paint(Color(0xFF666666));

  Paint _paint(Color c) => Paint()
    ..color = c;

  double _temp(num t) => _h / 2;

  @override
  bool shouldRepaint(ThermometerPainter old) => true;

}