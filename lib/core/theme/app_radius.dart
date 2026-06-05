import 'package:flutter/painting.dart';

/// Corner-radius tokens. `r*` are raw values, `br*` ready-made [BorderRadius].
abstract final class AppRadius {
  static const double r6 = 6; // license plate
  static const double r16 = 16; // chat bubbles
  static const double r19 = 19; // chat input pill
  static const double r30 = 30; // primary send button
  static const double full = 100; // circles / pills

  static const BorderRadius br6 = BorderRadius.all(Radius.circular(r6));
  static const BorderRadius br16 = BorderRadius.all(Radius.circular(r16));
  static const BorderRadius br19 = BorderRadius.all(Radius.circular(r19));
  static const BorderRadius br30 = BorderRadius.all(Radius.circular(r30));
  static const BorderRadius full100 = BorderRadius.all(Radius.circular(full));

  /// Received chat bubble — sharp top-left corner.
  static const BorderRadius received = BorderRadius.only(
    topRight: Radius.circular(r16),
    bottomLeft: Radius.circular(r16),
    bottomRight: Radius.circular(r16),
  );
}
