import 'dart:math' as math;

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

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
    final position = _position(size,time);
    final center = _center(size);
    _paintTail(canvas, size, position);
    _paintHand(canvas, center, position);
    _paintText(canvas, size, position);
  }

  Offset _center(Size size) => (Offset.zero & size).center;
  double     _x(DateTime t) => math.cos(_angle(t));
  double     _y(DateTime t) => math.sin(_angle(t));
  double _angle(DateTime t) => _angleRadians(t) - math.pi / 2.0;
  double _length(Size size) => size.shortestSide * 0.5 * _handSize();

  Offset _position(Size size, DateTime t) =>
    _center(size) + Offset(_x(t), _y(t)) * _length(size);

  Paint _handPaint() => Paint()
    ..color       = _color()
    ..strokeWidth = _lineWidth() / 7;

  Paint _trailPaint(int alpha) => Paint()
    ..color       = _color().withAlpha(alpha)
    ..strokeWidth = 1;

  void _paintHand(Canvas canvas, Offset center, Offset position) {
    final paint = _handPaint();
    final delta = _lineWidth() / 2;

    canvas.drawLine(center, position, paint);
    canvas.drawLine(Offset(center.dx - delta,center.dy + delta), position, paint);
    canvas.drawLine(Offset(center.dx + delta,center.dy - delta), position, paint);
  }

  void _paintTail(Canvas canvas, Size size, Offset position) {
    double alpha = 255;
    DateTime t = time;
    double x = _position(size,t).dx;
    double delta = 1;

    while (x > 0) {
      x = x - 1;
      delta = delta * 1.011;
      t = t.subtract(duration * 0.09);
      final y      = _position(size,t).dy + _wind(x,delta);
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
    _paintTextWithPainter(canvas, size, position, _textBackgroundPainter());
    _paintTextWithPainter(canvas, size, position, _textForegroundPainter());
  }

  void _paintTextWithPainter(Canvas canvas, Size size, Offset position, TextPainter painter) {
    painter.layout(minWidth: 0, maxWidth: size.width,);
    final at = position.translate(painter.width / -2, painter.height / -2);
    painter.paint(canvas, at);
  }

  double   _fontSize()                    => 20 + 5 * _angleRadians(time);
  TextSpan _textSpan(TextStyle textStyle) => TextSpan(text: _text(), style: textStyle,);

  TextPainter _textPainter(TextStyle textStyle) =>
    TextPainter(text: _textSpan(textStyle), textDirection: TextDirection.ltr,);

  TextPainter _textForegroundPainter() =>
      _textPainter(TextStyle(color:Colors.white, fontSize: _fontSize(),));

  TextPainter _textBackgroundPainter() =>
      _textPainter(TextStyle(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.black,
      fontSize: _fontSize(),));

  @override
  bool shouldRepaint(HandPainter old) => true;

}
