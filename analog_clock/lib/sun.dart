import 'dart:math' as math;import 'package:flutter/material.dart';

/// A sun that is drawn with [CustomPainter]
class Sun extends StatelessWidget {

  ThemeData theme;
  DateTime time;

  Sun(this.theme,this.time);

  SunPainter _painter() => SunPainter(time);

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

class SunPainter extends CustomPainter {

  DateTime time;

  SunPainter(@required this.time);

  @override
  void paint(Canvas canvas, Size size) {
      canvas.drawCircle(_center(size), _radius(size), _paint());
  }

  Paint _paint() => Paint()
    ..color = Colors.yellow
    ..strokeWidth = 1;

  Offset _center(Size size) => Offset(_x() * size.width,_y() * size.height);

  double _radius(Size size) => size.height/5;

  double _x() => 1.0 - _fractionOfDaytime();
  double _y() => 1.0 - math.sin(_fractionOfDaytime() * math.pi);

  double dawn = 0.25;
  double _fractionOfDaytime() => (_fractionOfDay() - dawn ) * 2.0;
  double _fractionOfDay() => (time.hour * 60 + time.minute) / (24 * 60);

  @override
  bool shouldRepaint(SunPainter old) => true;

}