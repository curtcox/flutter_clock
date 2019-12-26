class TimeCycle {

  static double at(DateTime time, double speed, double offset, double span, double floor) {
    return 1.0 - (_0_to_1(time,speed,offset) * span - floor);
  }

  static double _0_to_1(DateTime time, double speed, double offset) {
    double t = _driver(time) * speed + offset;
    return t - t.toInt();
  }

  static double _driver(DateTime time) =>
      (time.hour * 3600 + time.minute * 60 + time.second + time.millisecond / 1000) /
          (24 * 60 * 60);

}