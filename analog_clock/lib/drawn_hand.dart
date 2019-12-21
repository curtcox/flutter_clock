// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

import 'hand.dart';

/// A clock hand that is drawn with [CustomPainter]
///
/// The hand's length scales based on the clock's size.
/// This hand is used to build the second and minute hands, and demonstrates
/// building a custom hand.
class DrawnHand extends Hand {
  /// Create a const clock [Hand].
  ///
  const DrawnHand(
    @required HandFunction handFunction, @required DateTime time,
  )  : assert(handFunction != null), assert(time!=null),
        super(handFunction,time);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _HandPainter(
            handSize: handFunction.size(time),
            lineWidth: handFunction.thickness(time),
            angleRadians: handFunction.angleRadians(time),
            text: handFunction.text(time),
            color: handFunction.color(time),
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _HandPainter extends CustomPainter {
  _HandPainter({
    @required this.handSize,
    @required this.lineWidth,
    @required this.angleRadians,
    @required this.text,
    @required this.color,
  })  : assert(handSize != null),
        assert(lineWidth != null),
        assert(angleRadians != null),
        assert(color != null),
        assert(handSize >= 0.0),
        assert(handSize <= 1.0);

  double handSize;
  double lineWidth;
  double angleRadians;
  int text;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final position = _position(size);
    _paintLine(canvas, _center(size), position);
    _paintText(canvas, size, position, text);
  }

  Offset _center(Size size) => (Offset.zero & size).center;

  Offset _position(Size size) {
    final angle = angleRadians - math.pi / 2.0;
    final length = size.shortestSide * 0.5 * handSize;
    return _center(size) + Offset(math.cos(angle), math.sin(angle)) * length;
  }

  @override
  void _paintLine(Canvas canvas, Offset center, Offset position) {
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth / 7
      ..strokeCap = StrokeCap.square;
    final delta = lineWidth / 2;

    canvas.drawLine(center, position, linePaint);
    canvas.drawLine(Offset(center.dx - delta,center.dy + delta), position, linePaint);
    canvas.drawLine(Offset(center.dx + delta,center.dy - delta), position, linePaint);
  }

  void _paintText(Canvas canvas, Size size, Offset position, int text) {
    final textPainter = _textPainter();
    textPainter.layout(minWidth: 0, maxWidth: size.width,);
    final at = position.translate(textPainter.width / -2, textPainter.height / -2);
    textPainter.paint(canvas,at);
  }

  TextPainter _textPainter() {
    final fontSize = 20 + 5 * angleRadians;
    final textStyle = TextStyle(color:Colors.black, fontSize: fontSize,);
    final textSpan = TextSpan(text: text.toString(), style: textStyle,);
    return TextPainter(text: textSpan, textDirection: TextDirection.ltr,);
  }

  @override
  bool shouldRepaint(_HandPainter old) => true;

}
