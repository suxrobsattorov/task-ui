import 'package:flutter/painting.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static const List<BoxShadow> accentGlow = [
    BoxShadow(color: AppColors.accentGlow, blurRadius: 50, spreadRadius: -6),
  ];

  static const List<BoxShadow> greenGlow = [
    BoxShadow(color: Color(0x3300C950), blurRadius: 24, spreadRadius: -10),
  ];
}
