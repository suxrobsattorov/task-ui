import 'package:flutter/material.dart';

const Size kDesignFrame = Size(393, 852);

extension ResponsiveX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get width => screenSize.width;
  double get height => screenSize.height;
  EdgeInsets get safePadding => MediaQuery.viewPaddingOf(this);

  double get _wScale => width / kDesignFrame.width;
  double get _hScale => height / kDesignFrame.height;

  double w(double px) => px * _wScale;

  double h(double px) => px * _hScale;

  double sp(double px) => px * _wScale.clamp(0.9, 1.1);
}

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
}
