import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/components/components.dart';

class BattlePassPage extends StatelessWidget {
  const BattlePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        BattlePassPageBackground(),
        BattlePassPageExperienceBar(),
      ],
    );
  }
}
