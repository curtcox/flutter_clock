import 'package:flutter/material.dart';

abstract class ConditionalPainter extends StatelessWidget {

  final ThemeData theme;
  final DateTime time;
  final bool enabled;

  ConditionalPainter(this.theme,this.time,this.enabled);

  CustomPainter painter();

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