import 'package:analog_clock/time_cycle.dart';
import 'package:flutter/material.dart';

import 'conditional_painter.dart';

class Foggy extends ConditionalPainter {
  Foggy(time,enabled) : super(time,enabled,FoggyPainter(time));
}

class FoggyPainter extends TimedCustomPainter {

  DateTime time;
  Canvas _canvas;
  Size _size;

  FoggyPainter(this.time) : super(Duration(seconds: 1));

  @override
  void custom(Canvas canvas, Size size) {
      _canvas = canvas;
      _size = size;
      _paintFog();
  }

  void _paintFog() {
      _circle(2.50,gray(230),42,0.0);
      _circle(2.50,gray(240),42,0.25);
      _circle(2.50,gray(250),42,0.5);
      _circle(2.50,gray(255),42,0.75);
      _circle(2.60,gray(245),87,0.2);
      _circle(2.60,gray(220),87,0.4);
      _circle(2.60,gray(225),87,0.6);
      _circle(2.55,gray(237),870,0.6);
  }

  Color gray(int value) => Color.fromARGB(80, value, value, value);

  void _circle(double r, Color color, double speed,double offset) {
    _canvas.drawCircle(_center(speed,offset), _radius(r), _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double speed, double offset)
    => Offset(_x(speed,offset) * _size.width, 0.5 * _size.height );

  double _radius(double r) => (r * _size.height) / 5;

  double _x(double speed, double offset) => TimeCycle.at(time,speed,offset,1.8,0.4);

}