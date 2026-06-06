import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const String _f = 'Inter';

  static TextStyle get title18 => TextStyle(
    fontFamily: _f,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    letterSpacing: -0.018,
    color: AppColors.textPrimary,
  );

  static TextStyle get title16 => TextStyle(
    fontFamily: _f,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    color: AppColors.textPrimary,
  );

  static TextStyle get notif18 => TextStyle(
    fontFamily: _f,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    height: 24 / 18,
    letterSpacing: -0.018,
    color: AppColors.textPrimary,
  );

  static TextStyle get notif16 => TextStyle(
    fontFamily: _f,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
    color: AppColors.textPrimary,
  );

  static TextStyle get body16 => TextStyle(
    fontFamily: _f,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppColors.textPrimary,
  );

  static TextStyle get button => TextStyle(
    fontFamily: _f,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 20 / 16,
    color: AppColors.accent,
  );

  static TextStyle get message => TextStyle(
    fontFamily: _f,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: AppColors.textPrimary,
  );

  static TextStyle get timestamp => TextStyle(
    fontFamily: _f,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0.024,
    color: AppColors.textMuted,
  );

  static TextStyle get placeholder => TextStyle(
    fontFamily: _f,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: AppColors.textMuted,
  );
}
