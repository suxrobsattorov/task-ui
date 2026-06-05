import 'package:flutter/painting.dart';

abstract final class AppRadius {
  static const double r6 = 6;
  static const double r16 = 16;
  static const double r19 = 19;
  static const double r30 = 30;
  static const double full = 100;

  static const BorderRadius br6 = BorderRadius.all(Radius.circular(r6));
  static const BorderRadius br16 = BorderRadius.all(Radius.circular(r16));
  static const BorderRadius br19 = BorderRadius.all(Radius.circular(r19));
  static const BorderRadius br30 = BorderRadius.all(Radius.circular(r30));
  static const BorderRadius full100 = BorderRadius.all(Radius.circular(full));

  static const BorderRadius received = BorderRadius.only(
    topRight: Radius.circular(r16),
    bottomLeft: Radius.circular(r16),
    bottomRight: Radius.circular(r16),
  );
}
