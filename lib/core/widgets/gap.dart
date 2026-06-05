import 'package:flutter/widgets.dart';

/// Lightweight spacing widget — replaces repetitive `SizedBox` calls.
/// Works inside both Row and Column.
class Gap extends StatelessWidget {
  const Gap(this.size, {super.key});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size);
}
