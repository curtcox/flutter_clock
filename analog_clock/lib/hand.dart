// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:analog_clock/hand_function.dart';
import 'package:flutter/material.dart';

/// A base class for an analog clock hand-drawing widget.
///
/// This only draws one hand of the analog clock.
/// Put it in a [Stack] to have more than one hand.
abstract class Hand extends StatelessWidget {
  /// Create a const clock [Hand].
  ///
  /// All of the parameters are required and must not be null.
  const Hand(
    @required this.handFunction,
    @required this.time,
  )  : assert(handFunction != null),
        assert(time!=null);

  /// How to make a hand
  final HandFunction handFunction;

  /// What time is it
  final DateTime time;

}
