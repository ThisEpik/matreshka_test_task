import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';

class BattlePassPageBackground extends StatelessWidget {
  const BattlePassPageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Image.asset(
      CustomImagesAssets.battlePassBackground,
      fit: BoxFit.cover,
      width: size.width,
      height: size.height,
    );
  }
}
