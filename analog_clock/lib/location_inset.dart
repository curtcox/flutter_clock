import 'package:flutter/material.dart';

import 'conditional_painter.dart';
import 'outlined_text.dart';

class LocationInset extends ConditionalPainter {

  LocationInset(time,location) : super(time,true,
      LocationInsetPainter(location, Duration(seconds: 3)));

}

class LocationInsetPainter extends TimedCustomPainter  {
  final String _location;

  Canvas _canvas;
  Size _size;

  LocationInsetPainter(this._location,rate) : super(rate);

  @override
  void custom(Canvas canvas, Size size) {
    _size = size;
    _canvas = canvas;
    _paintText(_location, 1);
  }

  void _paintText(String text, double y) {
    Offset position = Offset(_size.width / 2,_size.height - y * 22);
    OutlinedText.paintText(_canvas, _size, position, text, 18);
  }

}