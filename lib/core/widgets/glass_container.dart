import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.borderRadius,
    this.fill,
    this.borderColor,
    this.borderWidth = 1,
    this.blurSigma = 18,
    this.boxShadow,
    this.padding,
    this.child,
  });

  final BorderRadius borderRadius;
  final Color? fill;

  final Color? borderColor;
  final double borderWidth;
  final double blurSigma;

  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

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
                  tint: borderColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final List<BoxShadow>? shadows = boxShadow;
    if (shadows == null || shadows.isEmpty) return surface;
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: shadows),
      child: surface,
    );
  }
}

class _GlassEdgePainter extends CustomPainter {
  const _GlassEdgePainter({
    required this.borderRadius,
    required this.width,
    this.tint,
  });

  final BorderRadius borderRadius;
  final double width;
  final Color? tint;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final RRect shape = borderRadius.toRRect(rect);

    _innerShadow(canvas, shape, const Offset(0, -0.59), 2.4, const Color(0x0FFFFFFF));
    _innerShadow(canvas, shape, const Offset(-1.19, -1.19), 2.4, const Color(0x2EFFFFFF));
    _innerShadow(canvas, shape, const Offset(1.78, 1.78), 3.0, const Color(0x80000000));

    if (width <= 0) return;
    final RRect rim = shape.deflate(width / 2);
    final Gradient gradient = tint == null
        ? const LinearGradient(
            begin: Alignment(-0.48, -1.14),
            end: Alignment(0.90, 1.08),
            stops: [0.0, 0.34, 0.68, 1.0],
            colors: [
              Color(0x59CFD8E5),
              Color(0x00454B5E),
              Color(0x33A9B9ED),
              Color(0x808290B9),
            ],
          )
        : LinearGradient(
            begin: const Alignment(-0.48, -1.14),
            end: const Alignment(0.90, 1.08),
            colors: [
              tint!.withValues(alpha: 0.55),
              tint!.withValues(alpha: 0.05),
              tint!.withValues(alpha: 0.40),
            ],
          );
    canvas.drawRRect(
      rim,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..shader = gradient.createShader(rect),
    );
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
      old.tint != tint;
}
