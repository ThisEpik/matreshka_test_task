import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/close_button.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';

class BattlePassPageCloseButton extends StatelessWidget {
  const BattlePassPageCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.calc,
      right: 80.calc,
      child: const CustomCloseButton(),
    );
  }
}
