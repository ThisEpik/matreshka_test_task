import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/global_components/xp_bar.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';

class BattlePassPageExperienceBar extends StatelessWidget {
  const BattlePassPageExperienceBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + 51.calc,
      top: 37.calc,
      child: SizedBox(
        width: 606.calc,
        height: 124.calc,
        child: Row(
          children: [
            const XpBar(
              level: 22,
              currentXp: 500,
              maxXp: 1600,
            ),
            SizedBox(width: 37.calc),
            Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [
                Row(
                  children: [
                    CustomSvgPicture(
                      iconPath: CustomSvgIconsAssets.timer,
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
                      colors: [
                        CustomColors.orangeGradien1,
                        CustomColors.orangeGradien2,
                      ],
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
  }
}
