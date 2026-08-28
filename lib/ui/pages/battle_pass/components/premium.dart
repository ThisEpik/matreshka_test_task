import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';

class BattlePassPagePremium extends StatelessWidget {
  const BattlePassPagePremium({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 81.calc,
      child: SizedBox(
        width: 588.calc,
        height: 589.calc,
        child: Stack(
          children: [
            const Center(
              child: CustomImageAsset(
                assetPath: ImagesAssets.womanCocktail,
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  SizedBox(height: 200.calc),
                  Text(
                    'Элитный пропуск',
                    style: TextStyle(
                      color: CustomColors.yellow,
                      fontWeight: .w600,
                      fontSize: 36.calc,
                    ),
                  ),
                  SizedBox(
                    width: 400.calc,
                    child: Text(
                      'Прокачай боевой пропуск и забери четкие скины, аксессуары и многое другое!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: -0.22,
                        height: 1.2,
                        color: CustomColors.white70,
                        fontWeight: .w500,
                        fontSize: 22.calc,
                      ),
                    ),
                  ),
                  SizedBox(height: 27.calc),
                  _Button(
                    onTap: () {},
                    title: 'Прокачать',
                    iconPath: SvgIconsAssets.crown,
                    isEnabled: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String iconPath;
  final bool isEnabled;

  const _Button({
    required this.onTap,
    required this.title,
    required this.iconPath,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 400.calc,
        height: 100.calc,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.calc),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: CustomColors.yellowGradient,
          ),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            CustomSvgPicture(
              iconPath: iconPath,
              color: CustomColors.brown,
              width: 36.calc,
              height: 36.calc,
            ),
            SizedBox(
              width: 24.calc,
            ),
            Text(
              title,
              style: const TextStyle(
                height: 1.2,
                letterSpacing: -0.22,
                color: CustomColors.brown,
                fontWeight: .w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
