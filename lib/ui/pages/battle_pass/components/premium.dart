import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/cubit/battle_pass_cubit.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/models/battle_pass_progression_state.dart';

class BattlePassPagePremium extends StatelessWidget {
  const BattlePassPagePremium({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattlePassCubit, BattlePassState>(
      builder: (context, state) {
        switch (state.battlePassProgressionState) {
          case BattlePassProgressionState.free:
            return _Content(
              imagePath: ImagesAssets.womanCocktail,
              title: 'Элитный пропуск',
              subTitle: 'Прокачай боевой пропуск и забери четкие скины, аксессуары и многое другое!',
              buttonTitle: 'Прокачать',
              buttonIconPath: SvgIconsAssets.crown,
              isEnabled: true,
              onTap: () {
                context.read<BattlePassCubit>().changeBattlePassProgression(BattlePassProgressionState.inProgress);
              },
            );
          case BattlePassProgressionState.inProgress:
            return _Content(
              imagePath: ImagesAssets.bpUpgrade,
              title: 'Повышение уровня',
              subTitle: 'Повышай уровень боевого пропуска и забирай новые награды!',
              buttonTitle: 'Повысить уровень',
              buttonIconPath: SvgIconsAssets.arrowUp,
              isEnabled: true,
              onTap: () {
                context.read<BattlePassCubit>().changeBattlePassProgression(BattlePassProgressionState.complete);
              },
            );
          case BattlePassProgressionState.complete:
            return _Content(
              imagePath: ImagesAssets.bpUpgrade,
              title: 'Повышение уровня',
              subTitle: 'Повышай уровень боевого пропуска и забирай новые награды!',
              buttonTitle: 'Достигнут максимальный уровень',
              isEnabled: false,
              onTap: () {
                context.read<BattlePassCubit>().changeBattlePassProgression(BattlePassProgressionState.free);
              },
            );
        }
      },
    );
  }
}

class _Content extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final String buttonTitle;
  final String? buttonIconPath;
  final bool isEnabled;

  const _Content({
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.buttonTitle,
    this.buttonIconPath,
    required this.isEnabled,
  });

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
            _Background(imagePath: imagePath),
            Center(
              child: Column(
                mainAxisSize: .min,
                children: [
                  SizedBox(height: 200.calc),
                  Text(
                    title,
                    style: TextStyle(
                      color: CustomColors.yellow,
                      fontWeight: .w600,
                      fontSize: 36.calc,
                    ),
                  ),
                  SizedBox(
                    width: 400.calc,
                    child: Text(
                      subTitle,
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
                    onTap: onTap,
                    title: buttonTitle,
                    iconPath: buttonIconPath,
                    isEnabled: isEnabled,
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

class _Background extends StatelessWidget {
  final String imagePath;

  const _Background({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<BattlePassCubit>().state;

    if (state.battlePassProgressionState == BattlePassProgressionState.free) {
      return Center(
        child: CustomImageAsset(
          assetPath: imagePath,
        ),
      );
    }

    return Center(
      child: Padding(
        padding: .only(bottom: 50.calc),
        child: CustomImageAsset(
          assetPath: imagePath,
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String? iconPath;
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
      onTapDown: (_) => onTap(),
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
            Visibility(
              visible: iconPath != null,
              child: Row(
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
                ],
              ),
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
