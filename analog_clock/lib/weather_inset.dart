import 'dart:async';

import 'package:analog_clock/cloudy.dart';
import 'package:analog_clock/drawn_hand.dart';
import 'package:analog_clock/hour_hand.dart';
import 'package:analog_clock/rainy.dart';
import 'package:analog_clock/second_hand.dart';
import 'package:analog_clock/minute_hand.dart';
import 'package:analog_clock/snowy.dart';
import 'package:analog_clock/sun.dart';
import 'package:analog_clock/thermometer.dart';
import 'package:analog_clock/thunderstorm.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

import 'foggy.dart';

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
