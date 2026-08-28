import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';

class BattlePassPage extends StatelessWidget {
  const BattlePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomImagesAssets.battlePassBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
