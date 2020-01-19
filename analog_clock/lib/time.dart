class Time {

    static bool _normal = true;
    static DateTime now() => _normal ? _t() : _fast();
    static DateTime _t() => DateTime.now();
    static DateTime _fast() {
       int millisPerSecond = 1;
       int millisPerMinute = millisPerSecond * 60;
       int millisPerHour   = millisPerMinute * 60;
       final t = _t();
       int x = t.minute * 1000 * 60 + t.second * 1000 + t.millisecond;
       int year = 2020;
       int month = 1;
       int day = 1;
       int hour = (x / millisPerHour).floor();
       int minute = ((x - (millisPerHour * hour))/millisPerMinute).floor();
       int second = (x / millisPerSecond).floor() % 60;
       return DateTime(year,month,day,hour,minute,second);
    }

}