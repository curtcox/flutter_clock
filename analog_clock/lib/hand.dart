import 'package:flutter/material.dart';

import 'conditional_painter.dart';

/// This only draws one hand of the analog clock.
class Hand extends ConditionalPainter {
  /// Create a const clock [Hand].
  ///
  /// All of the parameters are required and must not be null.
  Hand(time,painter) : super(time,true,painter);

}
