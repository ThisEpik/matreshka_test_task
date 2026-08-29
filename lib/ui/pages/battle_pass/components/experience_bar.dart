import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/global_components/xp_bar.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/cubit/battle_pass_cubit.dart';

class BattlePassPageExperienceBar extends StatelessWidget {
  const BattlePassPageExperienceBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattlePassCubit, BattlePassState>(
      builder: (context, state) {
        if (state.battlePassExperience == null) {
          return const SizedBox.shrink();
        }

        return Positioned(
          left: AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + AppDimensions.padding51,
          top: 37.calc,
          child: SizedBox(
            width: 606.calc,
            height: 124.calc,
            child: Row(
              children: [
                XpBar(
                  level: state.battlePassExperience!.level,
                  currentXp: state.battlePassExperience!.currentXP,
                  maxXp: state.battlePassExperience!.nextLevelXP,
                ),
                SizedBox(width: 37.calc),
                Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  children: [
                    Row(
                      children: [
                        CustomSvgPicture(
                          iconPath: SvgIconsAssets.timer,
                          width: 32.calc,
                          height: 32.calc,
                        ),
                        SizedBox(width: 10.calc),
                        Text(
                          '15д 12ч 42м',
                          style: TextStyle(
                            color: CustomColors.white40,
                            fontSize: 26.calc,
                            fontWeight: .w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.calc),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: CustomColors.orangeGradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      child: Text(
                        'Дай пять!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44.calc,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
