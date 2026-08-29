import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/domain/enums/battle_pass_reward_rarity.dart';
import 'package:matreshka_test_task/domain/enums/battle_pass_reward_status.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';
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

  List<Color> get gradientColors {
    switch (reward.rarity) {
      case BattlePassRewardRarity.common:
        return CustomColors.grayGradient;

      case BattlePassRewardRarity.uncomon:
        return CustomColors.blueGradient;

      case BattlePassRewardRarity.rare:
        return CustomColors.purpleGradient;

      case BattlePassRewardRarity.legendary:
        return CustomColors.darkOrangeGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        context.read<BattlePassCubit>().pickReward(reward);
      },
      child: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..setEntry(0, 1, -0.08)
            ..translateByDouble(-5.0, 0.0, 0.0, 1.0),
          child: Stack(
            children: [
              Opacity(
                opacity: reward.status == BattlePassRewardStatus.claimed ? .3 : 1,
                child: Container(
                  width: reward.status == BattlePassRewardStatus.reached ? 240.calc : 202.calc,
                  height: reward.status == BattlePassRewardStatus.reached ? 218.calc : 183.calc,
                  margin: .only(right: 20.calc),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.radius30),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: gradientColors,
                    ),
                    border: reward.status == BattlePassRewardStatus.reached
                        ? Border.all(
                            color: CustomColors.green,
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: CustomImageAsset(
                          assetPath: reward.image,
                          width: 152.calc,
                          height: 152.calc,
                        ),
                      ),
                      Positioned(
                        top: 10.calc,
                        left: 10.calc,
                        child: Visibility(
                          visible: reward.isPremium,
                          replacement: Container(
                            width: 55.calc,
                            height: 50.calc,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppDimensions.radius30.calc),
                              color: CustomColors.dark60,
                            ),
                            child: Center(
                              child: CustomSvgPicture(
                                iconPath: SvgIconsAssets.present,
                                color: CustomColors.white60,
                                width: 36.calc,
                                height: 36.calc,
                              ),
                            ),
                          ),
                          child: Container(
                            width: 55.calc,
                            height: 50.calc,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppDimensions.radius30.calc),
                              gradient: const LinearGradient(
                                begin: .topCenter,
                                end: .bottomCenter,
                                colors: CustomColors.yellowGradient2,
                              ),
                            ),
                            child: Center(
                              child: CustomSvgPicture(
                                iconPath: SvgIconsAssets.crown,
                                color: CustomColors.brown,
                                width: 36.calc,
                                height: 36.calc,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10.calc,
                        bottom: reward.status == BattlePassRewardStatus.reached ? 80.calc : 10.calc,
                        child: Visibility(
                          visible: reward.count != 1,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.002)
                              ..setEntry(0, 1, -0.08),
                            child: Container(
                              width: 69.calc,
                              height: 36.calc,
                              decoration: BoxDecoration(
                                color: CustomColors.dark60,
                                borderRadius: BorderRadius.circular(12.calc),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'x${reward.count}',
                                style: TextStyle(
                                  fontSize: 26.calc,
                                  fontWeight: .w500,
                                  color: CustomColors.white100,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: reward.status == BattlePassRewardStatus.reached,
                        child: Align(
                          alignment: .bottomCenter,
                          child: GestureDetector(
                            onTapDown: (_) {},
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002)
                                ..setEntry(0, 1, -0.08),
                              child: Container(
                                width: double.infinity,
                                height: 60.calc,
                                margin: .all(13.calc),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: .topCenter,
                                    end: .bottomCenter,
                                    colors: CustomColors.greenGradient,
                                  ),
                                  borderRadius: BorderRadius.circular(20.calc),
                                ),
                                child: Center(
                                  child: Text(
                                    'Забрать',
                                    style: TextStyle(
                                      color: CustomColors.white100,
                                      fontWeight: .w500,
                                      fontSize: 26.calc,
                                      height: AppDimensions.lineHeight,
                                      wordSpacing: AppDimensions.letterSpacing22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: reward.status == BattlePassRewardStatus.claimed,
                child: Positioned(
                  top: 15.calc,
                  right: 35.calc,
                  child: CustomSvgPicture(
                    iconPath: SvgIconsAssets.done,
                    width: 48.calc,
                    height: 48.calc,
                    color: CustomColors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
