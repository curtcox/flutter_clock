import 'package:flutter/material.dart';

class Foggy extends StatelessWidget {

  final ThemeData theme;
  final DateTime time;
  final bool foggy;

  Foggy(this.theme,this.time,this.foggy);

  FoggyPainter _painter() => FoggyPainter(time,foggy);

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

class FoggyPainter extends CustomPainter {

  DateTime time;
  bool foggy;
  Canvas _canvas;
  Size _size;

  FoggyPainter(@required this.time,this.foggy);

  @override
  void paint(Canvas canvas, Size size) {
      if (!foggy) {
          return;
      }
      _canvas = canvas;
      _size = size;
      _paintFog();
  }

  void _paintFog() {
      _circle(0.0,0.5,2.5,Color.fromARGB(80, 230, 230, 230),42,0.0);
      _circle(0.0,0.5,2.5,Color.fromARGB(80, 240, 240, 240),42,0.25);
      _circle(0.0,0.5,2.5,Color.fromARGB(80, 250, 250, 250),42,0.5);
      _circle(0.0,0.5,2.5,Color.fromARGB(80, 255, 255, 255),42,0.75);
      _circle(0.0,0.5,2.6,Color.fromARGB(80, 245, 245, 245),87,0.2);
      _circle(0.0,0.5,2.6,Color.fromARGB(80, 220, 220, 220),87,0.4);
      _circle(0.0,0.5,2.6,Color.fromARGB(80, 225, 225, 225),87,0.6);
  }

  void _circle(double x, double y, double r, Color color, double speed,double offset) {
    _canvas.drawCircle(_center(x,y,speed,offset), _radius(r), _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double x, double y, double speed, double offset)
    => Offset((_x(speed,offset) + x) * _size.width,  y * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _x(double speed, double offset) => 1.0 - _cycle(speed, offset);

  double _cycle(double speed, double offset) {
      double t = _time() * speed + offset;
      return (t - t.toInt()) * 1.8 - 0.4;
  }
  double _time() =>
      (time.hour * 3600.0 + time.minute * 60.0 + time.second + time.millisecond / 1000.0) /
          (24.0 * 60.0 * 60.0);

  @override
  bool shouldRepaint(FoggyPainter old) => true;

}