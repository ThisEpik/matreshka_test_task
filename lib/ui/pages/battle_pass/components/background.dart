import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';

class BattlePassPageBackground extends StatelessWidget {
  const BattlePassPageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          return Transform.translate(
            offset: Offset(-width * 0.06, 0),
            child: Transform.scale(
              scaleX: 1.2,
              scaleY: 1.2,
              child: Image.asset(
                ImagesAssets.battlePassBackground,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
