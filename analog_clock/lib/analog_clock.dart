// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'container_hand.dart';
import 'drawn_hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(milliseconds: 15) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  // There are many ways to apply themes to your clock. Some are:
  //  - Inherit the parent Theme (see ClockCustomizer in the flutter_clock_helper package).
  //  - Override the Theme.of(context).colorScheme.
  //  - Create your own [ThemeData], demonstrated in [AnalogClock].
  //  - Create a map of [Color]s to custom keys, demonstrated in [DigitalClock].
  ThemeData _customTheme(BuildContext context) =>
      // primary, highlight, accent -> Hour, Minute, Second hand.
      Theme.of(context).brightness == Brightness.light
      ? Theme.of(context).copyWith(
          primaryColor: Color(0xFF4285F4),
          highlightColor: Color(0xFF8AB4F8),
          accentColor: Color(0xFF669DF6),
          backgroundColor: Color(0xFFD2E3FC),
        )
      : Theme.of(context).copyWith(
          primaryColor: Color(0xFFD2E3FC),
          highlightColor: Color(0xFF4285F4),
          accentColor: Color(0xFF8AB4F8),
          backgroundColor: Color(0xFF3C4043),
        );

  DefaultTextStyle _weatherInfo(ThemeData customTheme) => DefaultTextStyle(
    style: TextStyle(color: customTheme.primaryColor),
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

  _hourHand(ThemeData customTheme) => DrawnHand(
      color: customTheme.primaryColor,
      thickness: 18,
      size: 0.5,
      angleRadians: (_now.hour + (_now.minute / 60)) * radiansPerHour,
    );

  _minuteHand(ThemeData customTheme) => DrawnHand(
      color: customTheme.highlightColor,
      thickness: 16,
      size: 0.9,
      angleRadians: _now.minute * radiansPerTick,
    );

  _secondHand(ThemeData customTheme) => DrawnHand(
      color: customTheme.accentColor,
      thickness: 4,
      size: 1,
      angleRadians: (_now.second + _now.millisecond / 1000) * radiansPerTick,
    );

  @override
  Widget build(BuildContext context) {
    final customTheme = _customTheme(context);
    final time = DateFormat.Hms().format(DateTime.now());
    final weatherInfo = _weatherInfo(customTheme);

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        color: customTheme.backgroundColor,
        child: Stack(
          children: [
            _secondHand(customTheme),
            _minuteHand(customTheme),
            _hourHand(customTheme),
            Positioned(
              left: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: weatherInfo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}