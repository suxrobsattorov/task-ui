import 'dart:ui';

import 'package:flutter/material.dart';

/// Frosted "liquid glass" surface (iOS 26 style) — the signature look of the
/// design (buttons, bubbles, header chips).
///
/// Rebuilds Figma's translucent glass with four light cues over a backdrop
/// blur:
///  * a vertical body gradient — a bright sheen on top fading to a
///    near-transparent bottom,
///  * a specular hairline rim, brightest at the top-left and wrapping to a
///    faint bottom-right edge (not a flat uniform border),
///  * a soft "wet" highlight along the top lip, and
///  * a soft outer drop shadow so the surface lifts off the background.
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

  /// Base tint of the body. When null a neutral white glass is used; pass a
  /// translucent colour (e.g. the cyan bubble fill) to tint the surface.
  final Color? fill;

  /// Base hue of the specular rim. Defaults to white.
  final Color? borderColor;
  final double borderWidth;
  final double blurSigma;

  /// Extra shadows (e.g. an accent glow) layered over the default depth shadow.
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  /// Soft depth shadow so the glass floats off the background.
  static const BoxShadow _depth = BoxShadow(
    color: Color(0x40000000),
    blurRadius: 18,
    offset: Offset(0, 10),
    spreadRadius: -8,
  );

  @override
  Widget build(BuildContext context) {
    final Color base = fill ?? const Color(0x14FFFFFF);

    // Body: brighter sheen on top → flat base fill toward the bottom.
    Widget body = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.55, 1.0],
          colors: [
            Color.alphaBlend(const Color(0x24FFFFFF), base),
            base,
            base,
          ],
        ),
      ),
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
          // Specular rim + top-lip highlight, painted above the body but
          // never intercepting taps.
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _GlassRimPainter(
                  borderRadius: borderRadius,
                  width: borderWidth,
                  color: borderColor ?? const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [_depth, ...?boxShadow],
      ),
      child: surface,
    );
  }
}

/// Paints the glass edge: a diagonal specular rim plus a soft top-lip glow.
class _GlassRimPainter extends CustomPainter {
  const _GlassRimPainter({
    required this.borderRadius,
    required this.width,
    required this.color,
  });

  final BorderRadius borderRadius;
  final double width;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (width <= 0) return;
    final Rect rect = Offset.zero & size;

    // Specular hairline: bright top-left → faint middle → soft bottom-right.
    final RRect rim = borderRadius.toRRect(rect).deflate(width / 2);
    canvas.drawRRect(
      rim,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.5, 1.0],
          colors: [
            color.withValues(alpha: 0.55),
            color.withValues(alpha: 0.05),
            color.withValues(alpha: 0.26),
          ],
        ).createShader(rect),
    );

    // Wet highlight along the very top lip (fades out by the vertical centre).
    final RRect lip = borderRadius.toRRect(rect).deflate(width * 1.5);
    canvas.drawRRect(
      lip,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width * 1.2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2)
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            color.withValues(alpha: 0.45),
            color.withValues(alpha: 0.0),
          ],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_GlassRimPainter old) =>
      old.borderRadius != borderRadius ||
      old.width != width ||
      old.color != color;
}
