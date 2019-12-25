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

  ThermometerPainter(this.unit,this.current,this.low,this.high);

  @override
  void paint(Canvas canvas, Size size) {
      _w = size.width;
      _h = size.height;
      canvas.drawRect(_edge(),   _black());
      canvas.drawRect(_center(), _glass());
      canvas.drawRect(_tempBar(), _red());
  }

  Rect _edge()    => _ltrb(_w - 5.5,             0,   _w,    _h);
  Rect _center()  => _ltrb(_w - 5.0,             0,   _w,    _h);
  Rect _tempBar() => _ltrb(_w - 3.0,_temp(current),   _w - 1,_h);
  Rect _ltrb(double l,double t,double r,double b) => Rect.fromLTRB(l,t,r,b);

  Paint   _red() => _paint(Colors.red);
  Paint _black() => _paint(Colors.black);
  Paint _glass() => _paint(Color(0xFFeeeeee));

  Paint _paint(Color c) => Paint()
    ..color = c;

  double _temp(num t) => _h / 2;

  @override
  bool shouldRepaint(ThermometerPainter old) => true;

}