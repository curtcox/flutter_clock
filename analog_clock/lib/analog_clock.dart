import 'dart:async';

import 'package:analog_clock/drawn_hand.dart';
import 'package:analog_clock/hour_hand.dart';
import 'package:analog_clock/second_hand.dart';
import 'package:analog_clock/minute_hand.dart';
import 'package:analog_clock/sun.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';


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
        Duration(milliseconds: 100) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

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


  _hourHand(ThemeData t)   =>
      DrawnHand(HourHand(t,widget.model), _now, Duration(minutes: 12), _windy());
  _minuteHand(ThemeData t) =>
      DrawnHand(MinuteHand(t),_now, Duration(minutes: 1), _windy());
  _secondHand(ThemeData t) =>
      DrawnHand(SecondHand(t),_now, Duration(seconds: 1), _windy());
  _sun(ThemeData t)        => Sun(t,_now);

  bool _windy() => _condition.toLowerCase() == 'windy';
  Color _backgroundColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? Color(0xFFA8DDFF) : Color(0xFF000000);

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hms().format(DateTime.now());
    final theme = Theme.of(context);
    final weatherInfo = _weatherInfo(theme);

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        color: _backgroundColor(context),
        child: Stack(
          children: [
            _sun(theme),
            _secondHand(theme),
            _minuteHand(theme),
            _hourHand(theme),
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
