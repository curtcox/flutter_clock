import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'outlined_text.dart';

class LocationInset extends StatelessWidget {

  final String _location;
  final DateTime _time;

  LocationInset(this._location,this._time);

  LocationInsetPainter _painter() => LocationInsetPainter(_location,_time);

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

class LocationInsetPainter extends CustomPainter {
  final String _location;
  final DateTime _time;

  Canvas _canvas;
  Size _size;

  LocationInsetPainter(this._location,this._time);

  @override
  void paint(Canvas canvas, Size size) {
    _size = size;
    _canvas = canvas;
    _paintText(_location, 1);
  }

  void _paintText(String text, double y) {
    Offset position = Offset(0,y * 22);
    OutlinedText.paintText(_canvas, _size, position, text, 18);
  }

  @override
  bool shouldRepaint(LocationInsetPainter old) => true;

}