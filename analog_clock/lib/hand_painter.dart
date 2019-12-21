import 'dart:math' as math;

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

import 'hand.dart';

/// [CustomPainter] that draws a clock hand.
class HandPainter extends CustomPainter {

  HandPainter(@required this.handFunction, @required this.time)
      : assert(handFunction != null), assert(time != null) ;

  HandFunction handFunction;
  DateTime time;

  double     _handSize() => handFunction.size(time);
  double    _lineWidth() => handFunction.thickness(time);
  double _angleRadians() => handFunction.angleRadians(time);
  int            _text() => handFunction.text(time);
  Color         _color() => handFunction.color(time);

  @override
  void paint(Canvas canvas, Size size) {
    final position = _position(size);
    final center = _center(size);
    _paintTail(canvas, center, position);
    _paintHand(canvas, center, position);
    _paintText(canvas, size, position, _text());
  }

  Offset _center(Size size) => (Offset.zero & size).center;

  Offset _position(Size size) {
    final angle  = _angleRadians() - math.pi / 2.0;
    final length = size.shortestSide * 0.5 * _handSize();
    return _center(size) + Offset(math.cos(angle), math.sin(angle)) * length;
  }

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

  void _paintTail(Canvas canvas, Offset center, Offset position) {
    final paint = _paint();

    for (int x=0; x<position.dx; x++) {
      final start = Offset(x.toDouble(),    position.dy);
      final end   = Offset((x+1).toDouble(),position.dy);
      canvas.drawLine(start, end, paint);
    }
  }

  void _paintText(Canvas canvas, Size size, Offset position, int text) {
    final textPainter = _textPainter();
    textPainter.layout(minWidth: 0, maxWidth: size.width,);
    final at = position.translate(textPainter.width / -2, textPainter.height / -2);
    textPainter.paint(canvas,at);
  }

  TextPainter _textPainter() {
    final fontSize = 20 + 5 * _angleRadians();
    final textStyle = TextStyle(color:Colors.black, fontSize: fontSize,);
    final textSpan = TextSpan(text: _text().toString(), style: textStyle,);
    return TextPainter(text: textSpan, textDirection: TextDirection.ltr,);
  }

  @override
  bool shouldRepaint(HandPainter old) => true;

}
