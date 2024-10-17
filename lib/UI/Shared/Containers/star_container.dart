import 'package:flutter/material.dart';
import 'dart:math';

class RoundedStar extends StatelessWidget {
  final double size;
  final Color color;

  const RoundedStar({Key? key, this.size = 50, this.color = Colors.yellow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RoundedStarPainter(color),
    );
  }
}

class _RoundedStarPainter extends CustomPainter {
  final Color color;

  _RoundedStarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;

    Path starPath = Path();
    const int numPoints = 5;
    final double innerRadius = radius * 0.5;

    for (int i = 0; i < numPoints * 2; i++) {
      double angle = (pi / numPoints) * i;
      double r = i.isEven ? radius : innerRadius;
      starPath.lineTo(
        cos(angle) * r + radius,
        sin(angle) * r + radius,
      );
    }
    starPath.close();

    // Clip the star with a rounded rectangle to round the edges a little bit
    RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(8),
    );

    canvas.clipRRect(roundedRect);
    canvas.drawPath(starPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}