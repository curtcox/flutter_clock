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
import 'package:analog_clock/time.dart';
import 'package:analog_clock/weather_inset.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

import 'foggy.dart';


class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = Time.now();
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
      final model = widget.model;
      _temperature = model.temperatureString;
      _temperatureRange = '(${model.lowString} - ${model.highString})';
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

  WeatherInset _weatherInset() =>
      WeatherInset(_temperature,_temperatureRange,_condition,_location,_timeString(),_now);

  String _timeString() => _model().is24HourFormat
      ? DateFormat('H:mm:ss').format(_now)
      : DateFormat('h:mm:ss').format(_now);

  static const   hour = Duration(minutes: 12);
  static const minute = Duration(minutes: 1);
  static const second = Duration(seconds: 1);
  static const   hand = HandPart.hand;
  static const   text = HandPart.text;
  ClockModel _model() => widget.model;
  _tail() => _is('windy') ? HandPart.windyTail : HandPart.tail;
  _hourHand(ThemeData t)   => DrawnHand(HourHand(t,_model()), _now, hour, hand);
  _minuteHand(ThemeData t) => DrawnHand(MinuteHand(t),_now, minute, hand);
  _secondHand(ThemeData t) => DrawnHand(SecondHand(t),_now, second, hand);
  _hourTail(ThemeData t)   => DrawnHand(HourHand(t,_model()), _now, hour, _tail());
  _minuteTail(ThemeData t) => DrawnHand(MinuteHand(t),_now, minute, _tail());
  _secondTail(ThemeData t) => DrawnHand(SecondHand(t),_now, second, _tail());
  _hourText(ThemeData t)   => DrawnHand(HourHand(t,_model()), _now, hour, text);
  _minuteText(ThemeData t) => DrawnHand(MinuteHand(t),_now, minute, text);
  _cloudy(ThemeData t)       => Cloudy(t,_now,0,_is('cloudy'));
  _foggy(ThemeData t)        => Foggy(t,_now,_is('foggy'));
  _rainy(ThemeData t)        => Rainy(t,_now,_is('rainy'));
  _snowy(ThemeData t)        => Snowy(t,_now,_is('snowy'));
  _thunderstorm(ThemeData t) => Thunderstorm(t,_now,_is('thunderstorm'));
  _thermometer(ThemeData t) {
    final m = widget.model;
    return Thermometer(t,m.unit,m.temperature,m.low,m.high);
  }
  bool _isStorming() => _is('rainy') || _is('thunderstorm');
  _sun(ThemeData t,BuildContext c) => Sun(t,_now,_isStorming(),_lightTheme(context));
  bool _lightTheme(context) => Theme.of(context).brightness == Brightness.light;
  bool _is(String condition) => _condition.toLowerCase() == condition;

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
            _sun(theme,context),
            _cloudy(theme),
            _foggy(theme),
            _thunderstorm(theme),
            _rainy(theme),
            _snowy(theme),
            _secondTail(theme),
            _minuteTail(theme),
            _hourTail(theme),
            _secondHand(theme),
            _minuteHand(theme),
            _hourHand(theme),
            _minuteText(theme),
            _hourText(theme),
            _thermometer(theme),
            _weatherInset()
          ],
        ),
      ),
    );
  }

}
