import 'package:flutter/material.dart';

class WeatherInset {

  final String _temperature;
  final String _temperatureRange;
  final String _condition;
  final String _location;
  final Color _color;

  WeatherInset(this._temperature, this._temperatureRange, this._condition, this._location, this._color);

  DefaultTextStyle _weatherInfo() => DefaultTextStyle(
    style: TextStyle(color: _color),
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
}
