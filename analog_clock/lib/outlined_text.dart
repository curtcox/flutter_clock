import 'package:flutter/material.dart';

class OutlinedText {

  static void paintText(Canvas canvas, Size size, Offset position,String text,double fontSize) {
    _paintTextWithPainter(canvas, size, position, _textBackgroundPainter(text,fontSize));
    _paintTextWithPainter(canvas, size, position, _textForegroundPainter(text,fontSize));
  }

  static void _paintTextWithPainter(Canvas canvas, Size size, Offset position, TextPainter painter) {
    painter.layout(minWidth: 0, maxWidth: size.width,);
    final at = position.translate(painter.width / -2, painter.height / -2);
    painter.paint(canvas, at);
  }

  static TextPainter _textPainter(String text,TextStyle textStyle) =>
      TextPainter(text: TextSpan(text: text,style: textStyle), textDirection: TextDirection.ltr,);

  static TextPainter _textForegroundPainter(String text, double fontSize) =>
      _textPainter(text,TextStyle(color:Colors.white, fontSize: fontSize,));

  static TextPainter _textBackgroundPainter(String text, double fontSize) =>
      _textPainter(text,TextStyle(
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.black,
        fontSize: fontSize,));

}