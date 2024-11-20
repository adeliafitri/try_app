import 'package:flutter/material.dart';

class GradientTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientIndicatorPainter();
  }
}

class _GradientIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF0F00FF), Color(0xFF32A2D5)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(
        Rect.fromLTWH(offset.dx, offset.dy, configuration.size!.width, 4),
      )
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Offset start = Offset(offset.dx, configuration.size!.height - 4);
    final Offset end = Offset(offset.dx + configuration.size!.width, configuration.size!.height - 4);

    canvas.drawLine(start, end, paint);
  }
}