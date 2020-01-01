import 'package:flutter/material.dart';
import 'ConditionalPainter.dart';
import 'drop_painter.dart';

class Rainy extends ConditionalPainter {

  Rainy(theme,time,enabled) : super(theme,time,enabled);

  painter() => DropPainter(time,800000,1.02,_gray(0x66));

  Color _gray(int value) => Color.fromARGB(0xAA, value, value, value);

}