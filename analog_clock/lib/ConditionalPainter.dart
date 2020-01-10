import 'package:flutter/material.dart';

abstract class ConditionalPainter extends StatelessWidget {

  final ThemeData theme;
  final DateTime time;
  final bool enabled;

  ConditionalPainter(this.theme,this.time,this.enabled);

  TimedCustomPainter painter();

  @override Widget build(BuildContext context) =>
    enabled ? _painted() : _empty();

  Widget _painted() =>
      Center(
        child: SizedBox.expand(
          child: CustomPaint(
            painter: painter(),
          ),
        ),
      );

  Widget _empty() => Center();

}

abstract class TimedCustomPainter extends CustomPainter {

  Duration _rate;
  DateTime _due = DateTime.now();

  TimedCustomPainter(this._rate);

  @override
  void paint(Canvas canvas, Size size) {
    custom(canvas, size);
    _due = DateTime.now().add(_rate);
  }

  void custom(Canvas canvas, Size size);

  @override
  bool shouldRepaint(TimedCustomPainter old) => DateTime.now().isAfter(_due);

}