import 'package:analog_clock/rainy.dart';
import 'package:flutter/material.dart';
import 'cloudy.dart';

class Thunderstorm extends StatelessWidget {
  final DateTime time;

  Thunderstorm(this.time);

  @override
  Widget build(BuildContext context) => _sky();

  Widget _sky() => Container(
        child: Stack(
          children: [
            Cloudy(time, 80, true),
            Rainy(time, true),
          ],
        ),
      );
}
