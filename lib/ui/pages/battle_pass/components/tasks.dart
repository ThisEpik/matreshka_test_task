import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';

class BattlePassPageTasks extends StatelessWidget {
  const BattlePassPageTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Task();
  }
}

class _Task extends StatelessWidget {
  const _Task();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + 51.calc,
      top: 220.calc,
      child: const Column(
        children: [
          _TopContainer(),
          _BottomContainer(),
        ],
      ),
    );
  }
}

class _BottomContainer extends StatelessWidget {
  const _BottomContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400.calc,
      height: 290.calc,
      decoration: BoxDecoration(
        color: CustomColors.gray3.withValues(alpha: 0.6),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.radius30),
          bottomRight: Radius.circular(AppDimensions.radius30),
        ),
      ),
      child: Column(
        mainAxisAlignment: .spaceEvenly,
        children: [
          Text(
            'Используйте определенный предмет (Энергетик) 10 раз.',
            textAlign: .center,
            style: TextStyle(
              color: CustomColors.white60,
              fontWeight: .w500,
              fontSize: 22.calc,
            ),
          ),

          GestureDetector(
            onTapDown: (_) {},
            child: Container(
              width: 320.calc,
              height: 74.calc,
              decoration: BoxDecoration(
                color: CustomColors.white10,
                borderRadius: BorderRadius.circular(AppDimensions.radius30),
              ),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  CustomSvgPicture(
                    iconPath: SvgIconsAssets.checkbox,
                    width: 30.calc,
                    height: 30.calc,
                  ),
                  SizedBox(width: 16.calc),
                  Text(
                    'Задания',
                    style: TextStyle(
                      color: CustomColors.white100,
                      fontSize: 26.calc,
                      fontWeight: .w500,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopContainer extends StatelessWidget {
  const _TopContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 30.calc),
      width: 400.calc,
      height: 110.calc,
      decoration: BoxDecoration(
        color: CustomColors.gray2.withValues(alpha: 0.6),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radius30),
          topRight: Radius.circular(AppDimensions.radius30),
        ),
      ),
      child: Row(
        children: [
          const CustomImageAsset(assetPath: ImagesAssets.xp),
          SizedBox(width: 12.calc),
          Text(
            'x 25',
            style: TextStyle(color: CustomColors.white100, fontSize: 26.calc, height: 1.2, letterSpacing: -0.22),
          ),
          const Spacer(),
          Container(
            width: 112.calc,
            height: 56.calc,
            decoration: BoxDecoration(
              color: CustomColors.dominant,
              borderRadius: BorderRadius.circular(20.calc),
            ),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 26.calc,
                    fontWeight: .w500,
                  ),
                  children: const [
                    TextSpan(
                      text: '3',
                      style: TextStyle(
                        color: CustomColors.green,
                      ),
                    ),
                    TextSpan(
                      text: ' / 5',
                      style: TextStyle(
                        color: CustomColors.gray4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
