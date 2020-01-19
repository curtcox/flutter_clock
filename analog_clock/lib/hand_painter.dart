import 'dart:math' as math;

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

import 'conditional_painter.dart';
import 'bounds.dart';
import 'hand_part.dart';
import 'mix.dart';
import 'outlined_text.dart';

/// [CustomPainter] that draws part of a clock hand.
class HandPainter extends TimedCustomPainter {

  final HandFunction handFunction;
  final DateTime time;
  final Duration duration;
  final HandPart part;

  HandPainter(this.handFunction,this.time,this.duration,this.part) : super(duration);

  double  _handSize() => handFunction.size(time);
  double _lineWidth() => handFunction.thickness(time);
  String      _text() => handFunction.text(time);
  Color      _color() => handFunction.color(time);

  double _angleRadians(DateTime t) => handFunction.angleRadians(t);

  @override
  void custom(Canvas canvas, Size size) {
    final length = _length(size);
    final inside = _position(size,time,length);
    final outside = _position(size,time,length * 1.03);
    final center = _center(size);
    if (part==HandPart.hand)      { _paintHand(canvas, center, inside, outside); }
    if (part==HandPart.text)      { _paintText(canvas, size, inside); }
    if (part==HandPart.tail)      { _paintTail(canvas, size, outside, length,false); }
    if (part==HandPart.windyTail) { _paintTail(canvas, size, outside, length,true); }
  }

  Offset _center(Size size) => (Offset.zero & size).center;
  double     _x(DateTime t) => math.cos(_angle(t));
  double     _y(DateTime t) => math.sin(_angle(t));
  double _angle(DateTime t) => _angleRadians(t) - math.pi / 2.0;
  double _length(Size size) => size.shortestSide * 0.5 * _handSize();

  Offset _position(Size size, DateTime t, length) =>
    _center(size) + Offset(_x(t), _y(t)) * length;

  Paint _hand()  => _paint(_color());
  Paint _black() => _paint(_mix(_color(),Colors.black,0.85));
  Paint _white() => _paint(_mix(_color(),Colors.white,0.85));
  Color _mix(Color a, Color b, double f) => Mix.of(a,b,f);

  Paint _paint(Color color) => Paint()
    ..color       = color
    ..strokeWidth = _lineWidth() / 7;

  Paint _trailPaint(int alpha) => Paint()
    ..color       = _color().withAlpha(alpha)
    ..strokeWidth = 2;

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

  void _paintTail(Canvas canvas, Size size, Offset position, double length,bool windy) {
    double alpha = 180;
    DateTime t = time;
    double x = _position(size,t,length).dx;
    double delta = 1;

    while (x > Bounds.left) {
      x = x - 1;
      delta = delta * 1.011;
      t = t.subtract(duration * 0.09);
      final wind   = windy ? _wind(x,delta) : 0.0;
      final y      = _position(size,t,length).dy + wind;
      final top    = Offset(x,y - delta);
      final bottom = Offset(x,y + delta);
      alpha = alpha * 0.999;
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

  double _wind(double x, double delta) =>
      math.sin(x * 0.1 + _shift() * 5.9) * delta * 1.7;

  void _paintText(Canvas canvas, Size size, Offset position) {
    OutlinedText.paintText(canvas,size,position,_text(),_fontSize());
  }

  double _fontSize() => 20 + 8 * _angleRadians(time);

}
