import 'package:flutter/painting.dart';

/// Corner-radius tokens. `r*` are raw values, `br*` are ready-made
/// [BorderRadius] objects for containers and clips.
abstract final class AppRadius {
  static const double r4 = 4;
  static const double r8 = 8;
  static const double r12 = 12;
  static const double r16 = 16;
  static const double r20 = 20;
  static const double r24 = 24;
  static const double full = 999;

  static const BorderRadius br8 = BorderRadius.all(Radius.circular(r8));
  static const BorderRadius br12 = BorderRadius.all(Radius.circular(r12));
  static const BorderRadius br16 = BorderRadius.all(Radius.circular(r16));
  static const BorderRadius br20 = BorderRadius.all(Radius.circular(r20));
  static const BorderRadius br24 = BorderRadius.all(Radius.circular(r24));
}
