import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'outlined_text.dart';

class WeatherInset extends StatelessWidget {

  final String _temp;
  final String _tempRange;
  final String _condition;
  final String _location;
  final String _timeString;
  final DateTime _time;

  WeatherInset(this._temp,this._tempRange,this._condition,this._location,this._timeString,this._time);

  WeatherInsetPainter _painter() => WeatherInsetPainter(_temp,_tempRange,_condition,_location,_timeString,_time);

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

class WeatherInsetPainter extends CustomPainter {
  final String _temp;
  final String _tempRange;
  final String _condition;
  final String _location;
  final String _timeString;
  final DateTime _time;

  Canvas _canvas;
  Size _size;

  WeatherInsetPainter(this._temp,this._tempRange,this._condition,this._location,this._timeString,this._time);

  @override
  void paint(Canvas canvas, Size size) {
    _paintText(_temp, 0);
    _paintText(_tempRange, 1);
    _paintText(_condition, 2);
    _paintText(_location, 3);
    _paintText(_timeString, 4);
  }

  void _paintText(String text, double y) {
    double fontSize = 20.0;
    Offset position = Offset(0,y * fontSize);
    OutlinedText.paintText(_canvas, _size, position, text, fontSize);
  }

  @override
  bool shouldRepaint(WeatherInsetPainter old) => true;

}