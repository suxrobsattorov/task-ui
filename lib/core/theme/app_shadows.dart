import 'package:flutter/painting.dart';

import 'app_colors.dart';

abstract final class AppShadows {
  static const List<BoxShadow> accentGlow = [
    BoxShadow(color: AppColors.accentGlow, blurRadius: 60),
  ];
}
