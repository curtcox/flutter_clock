// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

import 'hand.dart';
import 'hand_painter.dart';

/// A clock hand that is drawn with [CustomPainter]
///
/// The hand's length scales based on the clock's size.
/// This hand is used to build the second and minute hands, and demonstrates
/// building a custom hand.
class DrawnHand extends Hand {
  /// Create a const clock [Hand].
  ///
  const DrawnHand(
    @required HandFunction handFunction, @required DateTime time,
  )  : assert(handFunction != null), assert(time!=null),
        super(handFunction,time);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: HandPainter(
            handFunction.size(time),
            handFunction.thickness(time),
            handFunction.angleRadians(time),
            handFunction.text(time),
            handFunction.color(time),
          ),
        ),
      ),
    );
  }
}
