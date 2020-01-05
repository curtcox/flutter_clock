import 'dart:math' as math;

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

import 'outlined_text.dart';

/// [CustomPainter] that draws a clock hand.
class HandPainter extends CustomPainter {

  final HandFunction handFunction;
  final DateTime time;
  final Duration duration;
  final bool windy;

  HandPainter(@required this.handFunction, @required this.time, @required this.duration, @required this.windy)
      : assert(handFunction != null), assert(time != null), assert(duration != null) ;

  double  _handSize() => handFunction.size(time);
  double _lineWidth() => handFunction.thickness(time);
  String      _text() => handFunction.text(time);
  Color      _color() => handFunction.color(time);

  double _angleRadians(DateTime t) => handFunction.angleRadians(t);

  @override
  void paint(Canvas canvas, Size size) {
    final length = _length(size);
    final inside = _position(size,time,length);
    final outside = _position(size,time,length * 1.03);
    final center = _center(size);
    _paintTail(canvas, size, outside, length);
    _paintHand(canvas, center, inside, outside);
    _paintText(canvas, size, inside);
  }

  Offset _center(Size size) => (Offset.zero & size).center;
  double     _x(DateTime t) => math.cos(_angle(t));
  double     _y(DateTime t) => math.sin(_angle(t));
  double _angle(DateTime t) => _angleRadians(t) - math.pi / 2.0;
  double _length(Size size) => size.shortestSide * 0.5 * _handSize();

  Offset _position(Size size, DateTime t, length) =>
    _center(size) + Offset(_x(t), _y(t)) * length;

  Paint _hand()  => _paint(_color());
  Paint _black() => _paint(Colors.black);
  Paint _white() => _paint(Colors.white);

  Paint _paint(Color color) => Paint()
    ..color       = color
    ..strokeWidth = _lineWidth() / 7;

  Paint _trailPaint(int alpha) => Paint()
    ..color       = _color().withAlpha(alpha)
    ..strokeWidth = 1;

  void _paintHand(Canvas canvas, Offset center, Offset inside, Offset outside) {
    final hand  = _hand();
    final black = _black();
    final white = _white();
    final delta = _lineWidth() / 2;

    canvas.drawLine(center, inside, hand);
    canvas.drawLine(Offset(center.dx - delta,center.dy + delta), inside, hand);
    canvas.drawLine(Offset(center.dx + delta,center.dy - delta), inside, hand);
    canvas.drawLine(Offset(center.dx - 1,center.dy + delta), inside, black);
    canvas.drawLine(Offset(center.dx + 1,center.dy - delta), inside, black);
    canvas.drawLine(Offset(center.dx - delta - 3,center.dy + delta), outside, white);
    canvas.drawLine(Offset(center.dx + delta + 3,center.dy - delta), outside, white);
  }

  void _paintTail(Canvas canvas, Size size, Offset position, double length) {
    double alpha = 255;
    DateTime t = time;
    double x = _position(size,t,length).dx;
    double delta = 1;

    while (x > -122) {
      x = x - 1;
      delta = delta * 1.011;
      t = t.subtract(duration * 0.09);
      final y      = _position(size,t,length).dy + _wind(x,delta);
      final top    = Offset(x,y - delta);
      final bottom = Offset(x,y + delta);
      alpha = alpha * 0.995;
      if (alpha < 0) {
        return;
      }
      Paint paint = _trailPaint(alpha.toInt());
      canvas.drawLine(top, bottom, paint);
    }
  }

  double _shift() {
      final now = DateTime.now();
      return now.minute.toDouble() * 60 +
             now.second.toDouble() +
             now.millisecond / 1000;
  }

  double _wind(double x, double delta) => windy
      ? math.sin(x * 0.1 + _shift() * 5.9) * delta * 1.7 : 0.0;

  void _paintText(Canvas canvas, Size size, Offset position) {
    OutlinedText.paintText(canvas,size,position,_text(),_fontSize());
  }

  double _fontSize() => 20 + 8 * _angleRadians(time);

  @override
  bool shouldRepaint(HandPainter old) => true;

}
