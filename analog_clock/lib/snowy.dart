import 'package:flutter/material.dart';
import 'ConditionalPainter.dart';
import 'drop_painter.dart';

class Snowy extends ConditionalPainter {

  Snowy(theme,time,enabled) : super(theme,time,enabled);

  painter() => DropPainter(time,80000,1.0,_gray(0xFF));

  Color _gray(int value) => Color.fromARGB(0xFF, value, value, value);

}
