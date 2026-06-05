import 'package:flutter/material.dart';

/// Reference Figma frame size — the "Candidate Test" frames (iPhone 15 Pro).
const Size kDesignFrame = Size(393, 852);

/// Responsive helpers so [MediaQuery] is wrapped once, not scattered around.
///
/// For pixel-perfect work use raw token values by default; reach for
/// `w() / h() / sp()` only when a value must flex across screen sizes.
extension ResponsiveX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get width => screenSize.width;
  double get height => screenSize.height;
  EdgeInsets get safePadding => MediaQuery.viewPaddingOf(this);

  double get _wScale => width / kDesignFrame.width;
  double get _hScale => height / kDesignFrame.height;

  /// Scale a horizontal Figma value to the current width.
  double w(double px) => px * _wScale;

  /// Scale a vertical Figma value to the current height.
  double h(double px) => px * _hScale;

  /// Scale a font size; clamped so text never distorts on extreme screens.
  double sp(double px) => px * _wScale.clamp(0.9, 1.1);
}

/// Shorthand theme access.
extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
}
