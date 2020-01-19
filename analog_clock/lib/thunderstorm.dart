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
        child: Stack(
          children: [
            Cloudy(theme,time,80,true),
            Rainy(theme,time,true),
          ],
        ),
      );

}