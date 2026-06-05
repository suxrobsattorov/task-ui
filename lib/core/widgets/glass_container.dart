import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.borderRadius,
    this.fill,
    this.borderColor,
    this.borderGradient,
    this.borderWidth = 1,
    this.blurSigma = 24,
    this.innerShadows,
    this.boxShadow,
    this.padding,
    this.child,
  });

  final BorderRadius borderRadius;
  final Color? fill;

  final Color? borderColor;
  final Gradient? borderGradient;
  final double borderWidth;
  final double blurSigma;

  final List<BoxShadow>? innerShadows;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  static const List<BoxShadow> _bevel = [
    BoxShadow(color: Color(0x0FFFFFFF), offset: Offset(0, -0.59), blurRadius: 2.4),
    BoxShadow(color: Color(0x2EFFFFFF), offset: Offset(-1.19, -1.19), blurRadius: 2.4),
    BoxShadow(color: Color(0x80000000), offset: Offset(1.78, 1.78), blurRadius: 3.0),
  ];

  @override
  Widget build(BuildContext context) {
    final Color base = fill ?? AppColors.glassFill;

    Widget body = DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, color: base),
      child: padding == null ? child : Padding(padding: padding!, child: child),
    );

    if (blurSigma > 0) {
      body = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: body,
      );
    }

    final Widget surface = ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          body,
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _GlassEdgePainter(
                  borderRadius: borderRadius,
                  width: borderWidth,
                  borderColor: borderColor,
                  borderGradient: borderGradient,
                  innerShadows: innerShadows ?? _bevel,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final List<BoxShadow>? shadows = boxShadow;
    if (shadows == null || shadows.isEmpty) return surface;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _GlowPainter(borderRadius: borderRadius, shadows: shadows),
            ),
          ),
        ),
        surface,
      ],
    );
  }
}

class _GlowPainter extends CustomPainter {
  const _GlowPainter({required this.borderRadius, required this.shadows});

  final BorderRadius borderRadius;
  final List<BoxShadow> shadows;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect footprint = borderRadius.toRRect(rect);
    for (final BoxShadow s in shadows) {
      final double sigma = s.blurRadius <= 0 ? 0 : s.blurRadius * 0.57735 + 0.5;
      canvas.saveLayer(rect.inflate(s.blurRadius * 4 + s.spreadRadius.abs() + 16), Paint());
      final RRect glow = borderRadius.toRRect(
        rect.inflate(s.spreadRadius).shift(s.offset),
      );
      final Paint glowPaint = Paint()..color = s.color;
      if (sigma > 0) {
        glowPaint.maskFilter = MaskFilter.blur(BlurStyle.normal, sigma);
      }
      canvas.drawRRect(glow, glowPaint);
      canvas.drawRRect(footprint, Paint()..blendMode = BlendMode.clear);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_GlowPainter old) =>
      old.shadows != shadows || old.borderRadius != borderRadius;
}

class _GlassEdgePainter extends CustomPainter {
  const _GlassEdgePainter({
    required this.borderRadius,
    required this.width,
    required this.innerShadows,
    this.borderColor,
    this.borderGradient,
  });

  final BorderRadius borderRadius;
  final double width;
  final List<BoxShadow> innerShadows;
  final Color? borderColor;
  final Gradient? borderGradient;

  static const LinearGradient _rim = LinearGradient(
    begin: Alignment(-0.48, -1.14),
    end: Alignment(0.90, 1.08),
    stops: [0.0, 0.34, 0.68, 1.0],
    colors: [
      Color(0x59CFD8E5),
      Color(0x00454B5E),
      Color(0x33A9B9ED),
      Color(0x808290B9),
    ],
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect shape = borderRadius.toRRect(rect);

    for (final BoxShadow s in innerShadows) {
      _innerShadow(canvas, shape, s.offset, s.blurRadius, s.color);
    }

    if (width <= 0) return;
    final RRect rim = shape.deflate(width / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    if (borderGradient != null) {
      paint.shader = borderGradient!.createShader(rect);
    } else if (borderColor != null) {
      paint.color = borderColor!;
    } else {
      paint.shader = _rim.createShader(rect);
    }
    canvas.drawRRect(rim, paint);
  }

  void _innerShadow(
    Canvas canvas,
    RRect shape,
    Offset offset,
    double sigma,
    Color color,
  ) {
    final Path shapePath = Path()..addRRect(shape);
    final Path shifted = Path()..addRRect(shape.shift(offset));
    canvas.drawPath(
      Path.combine(PathOperation.difference, shapePath, shifted),
      Paint()
        ..color = color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, sigma),
    );
  }

  @override
  bool shouldRepaint(_GlassEdgePainter old) =>
      old.borderRadius != borderRadius ||
      old.width != width ||
      old.borderColor != borderColor ||
      old.borderGradient != borderGradient ||
      old.innerShadows != innerShadows;
}
