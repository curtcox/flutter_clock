import 'package:analog_clock/rainy.dart';
import 'package:flutter/material.dart';
import 'cloudy.dart';

class Thunderstorm extends StatelessWidget {

  final ThemeData theme;
  final DateTime time;
  final bool enabled;

  Thunderstorm(this.theme,this.time,this.enabled);

  @override Widget build(BuildContext context) => enabled ? _sky() : _empty();

  Widget _empty() => Center();
  Widget _sky() => Container(
        color: _skyColor(),
        child: Stack(
          children: [
            Cloudy(theme,time,true),
            Rainy(theme,time,true),
          ],
        ),
      );

  static final _bolt  = Color.fromARGB(0xCC, 255, 255, 255);
  static final _clear = Color.fromARGB(0x00, 255, 255, 255);

  Color _skyColor() => _flash() ? _bolt : _clear;

  bool _flash() => _flashSecond(time.second) && time.millisecond < 100;
  bool _flashSecond(second) =>
      second == 1  ||
      second == 37 ||
      second == 38;
}