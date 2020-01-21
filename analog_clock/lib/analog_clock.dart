import 'dart:async';

import 'package:analog_clock/cloudy.dart';
import 'package:analog_clock/hand_part.dart';
import 'package:analog_clock/hour_hand.dart';
import 'package:analog_clock/rainy.dart';
import 'package:analog_clock/second_hand.dart';
import 'package:analog_clock/minute_hand.dart';
import 'package:analog_clock/snowy.dart';
import 'package:analog_clock/sun.dart';
import 'package:analog_clock/thermometer.dart';
import 'package:analog_clock/thunderstorm.dart';
import 'package:analog_clock/time.dart';
import 'package:analog_clock/location_inset.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

import 'foggy.dart';
import 'lightning.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = Time.now();
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
      final model = widget.model;
      _condition = model.weatherString;
      _location = model.location;
    });
  }

  void _updateTime() {
    setState(() {
      _now = Time.now();
      _timer = Timer(
        Duration(milliseconds: 100) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  ClockModel _model() => widget.model;
  _lightning(ThemeData t) => Lightning(_now, _is('thunderstorm'));
  _locationInset(ThemeData t) => LocationInset(_now, _location);
  _thermometer(ThemeData t) {
    final m = widget.model;
    return Thermometer(t, m.unit, m.temperature, m.low, m.high);
  }

  bool _isStorming() => _is('rainy') || _is('thunderstorm');
  _sun(BuildContext c) => Sun(_now, _isStorming(), _lightTheme(context));
  bool _lightTheme(context) => Theme.of(context).brightness == Brightness.light;
  bool _is(String condition) => _condition.toLowerCase() == condition;

  static const hour = Duration(minutes: 12);
  static const minute = Duration(minutes: 1);
  static const second = Duration(seconds: 1);
  static const hand = HandPart.hand;
  static const text = HandPart.text;

  Stack _clock(ThemeData t) => Stack(children: [
        SecondHand.hand(t, _now, second, hand),
        MinuteHand.hand(t, _now, minute, hand),
        HourHand.hand(t, _model(), _now, hour, hand),
        MinuteHand.hand(t, _now, minute, text),
        HourHand.hand(t, _model(), _now, hour, text),
      ]);

  _tail() => _is('windy') ? HandPart.windyTail : HandPart.tail;
  Stack _tails(ThemeData t) => Stack(children: [
        SecondHand.hand(t, _now, second, _tail()),
        MinuteHand.hand(t, _now, minute, _tail()),
        HourHand.hand(t, _model(), _now, hour, _tail()),
      ]);

  Widget _weather() {
    if (_is('cloudy')) return Cloudy(_now, 0, true);
    if (_is('foggy')) return Foggy(_now, true);
    if (_is('thunderstorm')) return Thunderstorm(_now);
    if (_is('rainy')) return Rainy(_now, true);
    if (_is('snowy')) return Snowy(_now, true);
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.Hms().format(DateTime.now());
    final theme = Theme.of(context);

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        child: Stack(
          children: [
            _sun(context),
            _tails(theme),
            _weather(),
            _clock(theme),
            _lightning(theme),
            _thermometer(theme),
            _locationInset(theme)
          ],
        ),
      ),
    );
  }
}
