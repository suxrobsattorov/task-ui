import 'package:flutter/painting.dart';

/// Elevation / shadow tokens. Map Figma "Effects" (X, Y, blur, spread,
/// color, opacity) directly onto these [BoxShadow] lists.
abstract final class AppShadows {
  static const List<BoxShadow> subtle = [
    BoxShadow(
      color: Color(0x0D000000), // black 5%
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x14000000), // black 8%
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
}
