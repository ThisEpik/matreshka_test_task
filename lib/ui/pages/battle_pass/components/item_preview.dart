import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/cubit/battle_pass_cubit.dart';

class BattlePassPageItemPreview extends StatelessWidget {
  const BattlePassPageItemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topCenter,
      child: Padding(
        padding: .only(top: 105.calc),
        child: BlocBuilder<BattlePassCubit, BattlePassState>(
          builder: (context, state) {
            final reward = state.pickedReward;

            if (reward == null) {
              return const SizedBox.shrink();
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ...previousChildren,
                    ?currentChild,
                  ],
                );
              },
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                  child: child,
                );
              },
              child: _RewardPreview(
                key: ValueKey(reward.id),
                reward: reward,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RewardPreview extends StatelessWidget {
  const _RewardPreview({
    super.key,
    required this.reward,
  });

  final IBattlePassReward reward;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 521.calc,
      height: 700.calc,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutBack,
              tween: Tween(
                begin: 0.75,
                end: 1.0,
              ),
              builder: (context, scale, child) {
                final progress = ((scale - 0.75) / 0.25).clamp(0.0, 1.0);

                final rotation = -0.08 * (1.0 - progress);

                return Transform.rotate(
                  angle: rotation,
                  child: Transform.scale(
                    scale: scale,
                    child: child,
                  ),
                );
              },
              child: CustomImageAsset(
                assetPath: reward.image,
                width: 521.calc,
                height: 521.calc,
              ),
            ),
          ),

          if (reward.isPremium)
            Positioned(
              top: 515.calc,
              child: Container(
                width: 324.calc,
                height: 39.calc,
                padding: .symmetric(
                  horizontal: 12.calc,
                  vertical: 4.calc,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radius30,
                  ),
                  gradient: const LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: CustomColors.yellowGradient2,
                  ),
                ),
                child: Row(
                  children: [
                    CustomSvgPicture(
                      iconPath: SvgIconsAssets.crown,
                      color: CustomColors.brown,
                      width: 30.calc,
                      height: 30.calc,
                    ),
                    SizedBox(width: 10.calc),
                    Expanded(
                      child: Text(
                        'Доступно с прокачкой!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColors.brown,
                          fontWeight: .w500,
                          fontSize: 22.calc,
                          height: 1.2,
                          letterSpacing: -0.22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          Positioned(
            top: 570.calc,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Flexible(
                  child: Text(
                    reward.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.white100,
                      fontWeight: .w600,
                      fontSize: 36.calc,
                      height: 1.3,
                      letterSpacing: -0.22,
                    ),
                  ),
                ),
                SizedBox(width: 16.calc),
                CustomSvgPicture(
                  iconPath: SvgIconsAssets.info,
                  color: CustomColors.white100,
                  width: 36.calc,
                  height: 36.calc,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
