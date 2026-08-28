import 'package:flutter/material.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';

class BattlePassPageItemPreview extends StatelessWidget {
  const BattlePassPageItemPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topCenter,
      child: Padding(
        padding: .only(top: 105.calc),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          mainAxisSize: .min,
          children: [
            CustomImageAsset(
              assetPath: ImagesAssets.bodyArmour,
              width: 521.calc,
              height: 521.calc,
            ),
            Container(
              width: 324.calc,
              height: 39.calc,
              padding: .symmetric(horizontal: 12.calc, vertical: 4.calc),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radius30),
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
                  Center(
                    child: Text(
                      'Доступно с прокачкой!',
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
            SizedBox(height: 10.calc),
            Center(
              child: SizedBox(
                width: 214.calc,
                child: Row(
                  children: [
                    Text(
                      'Мега пак',
                      style: TextStyle(
                        color: CustomColors.white100,
                        fontWeight: .w600,
                        fontSize: 36.calc,
                        height: 1.3,
                        letterSpacing: -0.22,
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
            ),
          ],
        ),
      ),
    );
  }
}
