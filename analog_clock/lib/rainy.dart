import 'package:flutter/material.dart';
import 'conditional_painter.dart';
import 'drop_painter.dart';

class Rainy extends ConditionalPainter {

  Rainy(time,enabled) : super(time,enabled,
          DropPainter(time,1600000,1.02,_gray(0x66),Duration(milliseconds: 10)));

  static Color _gray(int value) => Color.fromARGB(0xAA, value, value, value);

}