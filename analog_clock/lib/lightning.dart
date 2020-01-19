import 'dart:ui';

import 'package:analog_clock/ConditionalPainter.dart';

import 'bounds.dart';

class Lightning extends ConditionalPainter {

  Lightning(theme,time,enabled) : super(theme,time,enabled,
      LightningPainter(Duration(milliseconds: 100)));
}

class LightningPainter extends TimedCustomPainter {

  LightningPainter(Duration rate) : super(rate);
  static const Color _bolt = Color(0xCCFFFFFF);

  @override
  void custom(Canvas canvas, Size size) {
    if (_flash()) {
      final paint = Paint()
        ..color = _bolt;
      canvas.drawRect(Bounds.rect(size), paint);
    }
  }

  bool _flash() => _flashSecond(now.second) && now.millisecond < 100;
  bool _flashSecond(second) =>
          second == 1  ||
          second == 37 ||
          second == 38;

}