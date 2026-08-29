import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/cubit/battle_pass_cubit.dart';

class BattlePassPageRewards extends StatelessWidget {
  const BattlePassPageRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        height: 360.calc,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<BattlePassCubit, BattlePassState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: state.rewards.length,
              padding: .only(
                left: AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + AppDimensions.padding51,
                right: AppDimensions.padding51,
              ),
              scrollDirection: .horizontal,
              itemBuilder: (context, index) {
                final reward = state.rewards[index];
                return _Reward(reward: reward);
              },
            );
          },
        ),
      ),
    );
  }
}

class _Reward extends StatelessWidget {
  final IBattlePassReward reward;

  const _Reward({required this.reward});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..setEntry(0, 1, -0.08)
          ..translate(-5.0, 0.0),
        child: Container(
          width: 202.calc,
          height: 183.calc,
          margin: .only(right: 20.calc),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.calc),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF303136),
                Color(0xFF202125),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF4A4B50),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
