import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';

class XpBar extends StatelessWidget {
  final int level;
  final int currentXp;
  final int maxXp;

  const XpBar({
    super.key,
    required this.level,
    required this.currentXp,
    required this.maxXp,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentXp / maxXp).clamp(0.0, 1.0);

    return SizedBox(
      width: 100.calc,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 90.calc,
            height: 90.calc,
            child: CustomPaint(
              painter: _LevelProgressPainter(
                progress: progress,
              ),
              child: Center(
                child: Text(
                  '$level',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.calc,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 6.calc),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$currentXp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.calc,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' / $maxXp',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16.calc,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelProgressPainter extends CustomPainter {
  const _LevelProgressPainter({
    required this.progress,
  });

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final strokeWidth = 7.calc;
    final radius = size.width / 2 - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..color = CustomColors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..isAntiAlias = true
      ..color = CustomColors.white60
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Background ring.
    canvas.drawCircle(
      center,
      radius,
      backgroundPaint,
    );

    if (progress <= 0) {
      return;
    }

    if (progress >= 1) {
      canvas.drawCircle(
        center,
        radius,
        progressPaint,
      );
      return;
    }

    final path = Path();

    path.addArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -math.pi / 2,
      math.pi * 2 * progress,
    );

    canvas.drawPath(
      path,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _LevelProgressPainter oldDelegate,
  ) {
    return oldDelegate.progress != progress;
  }
}
