import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';

class BattlePassPageExperienceBar extends StatelessWidget {
  const BattlePassPageExperienceBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 347.calc,
      top: 37.calc,
      child: Container(
        decoration: const BoxDecoration(color: Colors.red),
        width: 606.calc,
        height: 124.calc,
        child: const Text('asdasd'),
      ),
    );
  }
}
