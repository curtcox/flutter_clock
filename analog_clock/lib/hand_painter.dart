import 'dart:math' as math;

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

import 'hand.dart';

/// [CustomPainter] that draws a clock hand.
class HandPainter extends CustomPainter {

  HandPainter(@required this.handFunction, @required this.time, @required this.duration)
      : assert(handFunction != null), assert(time != null), assert(duration != null) ;

  HandFunction handFunction;
  DateTime time;
  Duration duration;

  double  _handSize() => handFunction.size(time);
  double _lineWidth() => handFunction.thickness(time);
  int         _text() => handFunction.text(time);
  Color      _color() => handFunction.color(time);

  double _angleRadians(DateTime t) => handFunction.angleRadians(t);

  @override
  void paint(Canvas canvas, Size size) {
    final position = _position(size,time);
    final center = _center(size);
    _paintTail(canvas, size, position);
    _paintHand(canvas, center, position);
    _paintText(canvas, size, position, _text());
  }

  Offset _center(Size size) => (Offset.zero & size).center;
  double     _x(DateTime t) => math.cos(_angle(t));
  double     _y(DateTime t) => math.sin(_angle(t));
  double _angle(DateTime t) => _angleRadians(t) - math.pi / 2.0;
  double _length(Size size) => size.shortestSide * 0.5 * _handSize();

  Offset _position(Size size, DateTime t) =>
    _center(size) + Offset(_x(t), _y(t)) * _length(size);

  Paint _paint() => Paint()
    ..color = _color()
    ..strokeWidth = _lineWidth() / 7
    ..strokeCap = StrokeCap.square;

  void _paintHand(Canvas canvas, Offset center, Offset position) {
    final paint = _paint();
    final delta = _lineWidth() / 2;

    canvas.drawLine(center, position, paint);
    canvas.drawLine(Offset(center.dx - delta,center.dy + delta), position, paint);
    canvas.drawLine(Offset(center.dx + delta,center.dy - delta), position, paint);
  }

  void _paintTail(Canvas canvas, Size size, Offset position) {
    final paint = _paint();
    DateTime t = time;
    Offset last = _position(size,t);
    double x = last.dx;

    while(x>0) {
      final start = last;
      x = x - 1;
      t = t.subtract(duration * 0.09);
      last  = Offset(x,_position(size,t).dy);
      canvas.drawLine(start, last, paint);
    }
  }

  void _paintText(Canvas canvas, Size size, Offset position, int text) {
    final textPainter = _textPainter();
    textPainter.layout(minWidth: 0, maxWidth: size.width,);
    final at = position.translate(textPainter.width / -2, textPainter.height / -2);
    textPainter.paint(canvas,at);
  }

  TextPainter _textPainter() {
    final fontSize = 20 + 5 * _angleRadians(time);
    final textStyle = TextStyle(color:Colors.black, fontSize: fontSize,);
    final textSpan = TextSpan(text: _text().toString(), style: textStyle,);
    return TextPainter(text: textSpan, textDirection: TextDirection.ltr,);
  }

  @override
  bool shouldRepaint(HandPainter old) => true;

}
