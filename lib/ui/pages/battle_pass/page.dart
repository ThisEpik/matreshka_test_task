import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/components/components.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/cubit/battle_pass_cubit.dart';

class BattlePassPage extends StatelessWidget {
  const BattlePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BattlePassCubit(),
      child: const Stack(
        children: [
          BattlePassPageBackground(),
          BattlePassPageExperienceBar(),
          BattlePassPageCloseButton(),
          BattlePassPagePremium(),
        ],
      ),
    );
  }
}
