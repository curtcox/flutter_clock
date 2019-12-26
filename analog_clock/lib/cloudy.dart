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
      _cloud1(0.0,100);
      _cloud2(0.1,200);
      _cloud3(0.2,300);
      _cloud1(0.3,150);
      _cloud2(0.4,250);
      _cloud3(0.5,350);
      _cloud1(0.6,050);
      _cloud2(0.7,175);
      _cloud3(0.8,275);
      _cloud1(0.9,125);
      _cloud2(1.0,145);
  }

  void _cloud1(double y, double speed) {
      _circle(-0.05,  0.01 + y,  0.6,  Color(0xccFFFFFF), speed);
      _circle( 0.0,   0.02 + y,  0.75, Color(0xccEEEEEE), speed);
      _circle( 0.07,  0.06 + y,  0.5,  Color(0xccF8F8F8), speed);
  }

  void _cloud2(double y, double speed) {
    _circle(-0.04,  0.01 + y,  0.6,  Color(0xccFFFFFF), speed);
    _circle(-0.08,  0.0  + y,  0.6,  Color(0xccEEEEEE), speed);
    _circle( 0.09,  0.06 + y,  0.6,  Color(0xccF8F8F8), speed);
    _circle( 0.06, -0.06 + y,  0.7,  Color(0xccFBFBFB), speed);
  }

  void _cloud3(double y, double speed) {
    _circle(-0.04,  0.02 + y,  0.55,  Color(0xccFFFFFF), speed);
    _circle(-0.08, -0.0  + y,  0.65,  Color(0xccEEEEEE), speed);
    _circle( 0.08,  0.06 + y,  0.6,   Color(0xccF8F8F8), speed);
    _circle( 0.06, -0.04 + y,  0.44,  Color(0xccFBFBFB), speed);
    _circle(-0.06, -0.06 + y,  0.68,  Color(0xccF4F4F4), speed);
  }

  void _circle(double x, double y, double r, Color color, double speed) {
    _canvas.drawCircle(_center(x,y,speed), _radius(r), _paint(color));
  }

  Paint _paint(Color color) => Paint()
    ..color = color;

  Offset _center(double x, double y, double speed)
    => Offset((_x(speed) + x) * _size.width,  y * _size.height);

  double _radius(double r) => (r * _size.height) / 5;

  double _x(double speed) => 1.0 - _cycle(speed);

  double _cycle(double speed) {
      double t = _time() * speed;
      return (t - t.toInt()) * 1.4 - 0.2;
  }
  double _time() =>
      (time.hour * 3600.0 + time.minute * 60.0 + time.second + time.millisecond / 1000.0) /
          (24.0 * 60.0 * 60.0);

  @override
  bool shouldRepaint(CloudyPainter old) => true;

}