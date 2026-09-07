import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Circular heritage watermark used on M-PESA Ethiopia marketing.
class AuthCardPattern extends StatelessWidget {
  const AuthCardPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: CustomPaint(
        size: Size.square(250),
        painter: _HeritageMandalaPainter(),
      ),
    );
  }
}

class _HeritageMandalaPainter extends CustomPainter {
  const _HeritageMandalaPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final stroke = Paint()
      ..color = Colors.white.withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;

    final fill = Paint()
      ..color = Colors.white.withValues(alpha: 0.16)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    for (final t in [0.98, 0.84, 0.70, 0.56, 0.42, 0.28, 0.16]) {
      canvas.drawCircle(center, radius * t, stroke);
    }

    _drawTeeth(canvas, center, radius * 0.88, radius * 0.98, 36, fill);
    _drawDots(canvas, center, radius * 0.77, 28, 2.1, fill);
    _drawPills(canvas, center, radius * 0.63, 18, stroke);
    _drawDots(canvas, center, radius * 0.49, 22, 1.8, fill);
    _drawPetals(canvas, center, radius * 0.20, radius * 0.38, 10, stroke);
    _drawDots(canvas, center, radius * 0.14, 10, 1.5, fill);
    canvas.drawCircle(center, radius * 0.06, stroke);
  }

  void _drawTeeth(
    Canvas canvas,
    Offset center,
    double inner,
    double outer,
    int count,
    Paint paint,
  ) {
    for (var i = 0; i < count; i++) {
      final angle = (math.pi * 2 / count) * i;
      final next = angle + math.pi * 2 / count;
      final mid = (angle + next) / 2;
      final path = Path()
        ..moveTo(
          center.dx + math.cos(angle) * inner,
          center.dy + math.sin(angle) * inner,
        )
        ..lineTo(
          center.dx + math.cos(mid) * outer,
          center.dy + math.sin(mid) * outer,
        )
        ..lineTo(
          center.dx + math.cos(next) * inner,
          center.dy + math.sin(next) * inner,
        )
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  void _drawDots(
    Canvas canvas,
    Offset center,
    double radius,
    int count,
    double size,
    Paint paint,
  ) {
    for (var i = 0; i < count; i++) {
      final angle = (math.pi * 2 / count) * i;
      canvas.drawCircle(
        Offset(
          center.dx + math.cos(angle) * radius,
          center.dy + math.sin(angle) * radius,
        ),
        size,
        paint,
      );
    }
  }

  void _drawPills(
    Canvas canvas,
    Offset center,
    double radius,
    int count,
    Paint paint,
  ) {
    for (var i = 0; i < count; i++) {
      final angle = (math.pi * 2 / count) * i;
      final dx = math.cos(angle);
      final dy = math.sin(angle);
      final origin = Offset(center.dx + dx * radius, center.dy + dy * radius);
      canvas.save();
      canvas.translate(origin.dx, origin.dy);
      canvas.rotate(angle);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTWH(-7, -2.2, 14, 4.4),
          const Radius.circular(3),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  void _drawPetals(
    Canvas canvas,
    Offset center,
    double inner,
    double outer,
    int count,
    Paint paint,
  ) {
    for (var i = 0; i < count; i++) {
      final angle = (math.pi * 2 / count) * i;
      final tip = Offset(
        center.dx + math.cos(angle) * outer,
        center.dy + math.sin(angle) * outer,
      );
      final left = Offset(
        center.dx + math.cos(angle - 0.22) * inner,
        center.dy + math.sin(angle - 0.22) * inner,
      );
      final right = Offset(
        center.dx + math.cos(angle + 0.22) * inner,
        center.dy + math.sin(angle + 0.22) * inner,
      );
      final path = Path()
        ..moveTo(left.dx, left.dy)
        ..quadraticBezierTo(tip.dx, tip.dy, right.dx, right.dy);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
