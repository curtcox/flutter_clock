import 'package:flutter/material.dart';
import 'dart:math' as math;

class WeatherInset {

  final String _temperature;
  final String _temperatureRange;
  final String _condition;
  final String _location;
  final DateTime _time;

  WeatherInset(this._temperature, this._temperatureRange, this._condition, this._location, this._time);

  DefaultTextStyle _weatherInfo() => DefaultTextStyle(
    style: TextStyle(color: _color()),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_temperature),
        Text(_temperatureRange),
        Text(_condition),
        Text(_location),
      ],
    ),
  );

  Positioned positioned() => Positioned(
        left: 0,
        bottom: 0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: _weatherInfo(),
        ),
      );

  Color _color() => Color.fromARGB(255, _r(), _g(), _b());

  int _r() => (math.sin(_fractionOfDay() * 24 * 3 * 17) * 255).floor();
  int _g() => (math.sin(_fractionOfDay() * 24 * 5 * 19) * 255).floor();
  int _b() => (math.sin(_fractionOfDay() * 24 * 7 * 23) * 255).floor();
  double _fractionOfDay() => (_time.hour * 60 * 60 + _time.minute * 60 + _time.second) / (24 * 60 * 60);

}
