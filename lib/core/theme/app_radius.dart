import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract final class AppRadius {
  static const double r6 = 6;
  static const double r16 = 16;
  static const double r19 = 19;
  static const double r30 = 30;
  static const double full = 100;

  static BorderRadius get br6 => BorderRadius.all(Radius.circular(r6.r));
  static BorderRadius get br16 => BorderRadius.all(Radius.circular(r16.r));
  static BorderRadius get br19 => BorderRadius.all(Radius.circular(r19.r));
  static BorderRadius get br30 => BorderRadius.all(Radius.circular(r30.r));
  static BorderRadius get full100 => BorderRadius.all(Radius.circular(full.r));

  static BorderRadius get received => BorderRadius.only(
    topRight: Radius.circular(r16.r),
    bottomLeft: Radius.circular(r16.r),
    bottomRight: Radius.circular(r16.r),
  );
}
