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
    _size = size;
    _canvas = canvas;
    _paintText(_temp, 1);
    _paintText(_condition, 2);
    _paintText(_timeString, 3);
  }

  void _paintText(String text, double y) {
    Offset position = Offset(0,y * 22);
    OutlinedText.paintText(_canvas, _size, position, text, 18);
  }

  @override
  bool shouldRepaint(WeatherInsetPainter old) => true;

}