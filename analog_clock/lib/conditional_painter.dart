import 'package:flutter/material.dart';

abstract class ConditionalPainter extends StatelessWidget {

  final DateTime time;
  final bool enabled;
  final TimedCustomPainter painter;

  ConditionalPainter(this.time,this.enabled,this.painter);

  @override Widget build(BuildContext context) =>
    enabled ? _painted() : _empty();

  Widget _painted() {
    painter.now = time;
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: painter,
        ),
      ),
    );
  }
  Widget _empty() => Center();

}

abstract class TimedCustomPainter extends CustomPainter {

  Duration _rate;
  DateTime _due;
  DateTime now;

  TimedCustomPainter(this._rate);

  @override
  void paint(Canvas canvas, Size size) {
    custom(canvas, size);
    _setDueAt();
  }

  void _setDueAt() {
    _due = now.add(_rate);
  }

  void custom(Canvas canvas, Size size);

  @override
  bool shouldRepaint(TimedCustomPainter old) {
      _acceptOldPainterInfo(old);
      return _overdue();
  }

  void _acceptOldPainterInfo(TimedCustomPainter old) {
      if (_due==null && old._due != null) {
          _due = old._due;
      }
  }

  bool _overdue() => _due==null || now.isAfter(_due);

}