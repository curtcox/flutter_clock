import 'dart:ui';

class Mix {

  static Color of(Color a, Color b, double f) =>
      Color.fromARGB(255,_mix(a.red,b.red,f),_mix(a.green,b.green,f),_mix(a.blue,b.blue,f));

  static int _mix(int a, int b, double f) => (b * f + a * (1.0 - f)).toInt();

}