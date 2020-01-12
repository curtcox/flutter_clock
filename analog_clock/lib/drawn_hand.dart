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
class DrawnHand extends Hand {
  /// Create a const clock [Hand].
  ///
  const DrawnHand(HandFunction handFunction, DateTime time, Duration duration, HandPart handPart)
      : assert(handFunction != null), assert(time!=null), assert(duration!=null),
        super(handFunction,time,duration,handPart);


  HandPainter _handPainter() => HandPainter(handFunction,time,duration,handPart);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _handPainter(),
        ),
      ),
    );
  }
}

enum HandPart {
  tail,
  windyTail,
  hand,
  text
}