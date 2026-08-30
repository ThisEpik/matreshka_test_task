import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
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
        return Positioned(
          right: MediaQuery.viewPaddingOf(context).right,
          top: 81.calc,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            reverseDuration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            layoutBuilder: (currentChild, previousChildren) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  ...previousChildren,
                  ?currentChild,
                ],
              );
            },
            transitionBuilder: (child, animation) {
              final slideAnimation =
                  Tween<Offset>(
                    begin: const Offset(0.08, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

              final scaleAnimation =
                  Tween<double>(
                    begin: 0.96,
                    end: 1,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: child,
                  ),
                ),
              );
            },
            child: KeyedSubtree(
              key: ValueKey(state.battlePassProgressionState),
              child: _Content(
                progressionState: state.battlePassProgressionState,
                onTap: () {
                  final cubit = context.read<BattlePassCubit>();

                  switch (state.battlePassProgressionState) {
                    case BattlePassProgressionState.free:
                      cubit.changeBattlePassProgression(
                        BattlePassProgressionState.inProgress,
                      );

                    case BattlePassProgressionState.inProgress:
                      cubit.changeBattlePassProgression(
                        BattlePassProgressionState.complete,
                      );

                    case BattlePassProgressionState.complete:
                      cubit.changeBattlePassProgression(
                        BattlePassProgressionState.free,
                      );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  final BattlePassProgressionState progressionState;
  final VoidCallback onTap;

  const _Content({
    required this.progressionState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final config = switch (progressionState) {
      BattlePassProgressionState.free => const _ContentConfig(
        imagePath: ImagesAssets.womanCocktail,
        title: 'Элитный пропуск',
        subTitle: 'Прокачай боевой пропуск и забери четкие скины, аксессуары и многое другое!',
        buttonTitle: 'Прокачать',
        buttonIconPath: SvgIconsAssets.crown,
        isEnabled: true,
      ),
      BattlePassProgressionState.inProgress => const _ContentConfig(
        imagePath: ImagesAssets.bpUpgrade,
        title: 'Повышение уровня',
        subTitle: 'Повышай уровень боевого пропуска и забирай новые награды!',
        buttonTitle: 'Повысить уровень',
        buttonIconPath: SvgIconsAssets.arrowUp,
        isEnabled: true,
      ),
      BattlePassProgressionState.complete => const _ContentConfig(
        imagePath: ImagesAssets.bpUpgrade,
        title: 'Повышение уровня',
        subTitle: 'Повышай уровень боевого пропуска и забирай новые награды!',
        buttonTitle: 'Достигнут максимальный уровень',
        buttonIconPath: null,
        isEnabled: false,
      ),
    };

    return SizedBox(
      width: 588.calc,
      height: 589.calc,
      child: Stack(
        children: [
          _Background(
            imagePath: config.imagePath,
            progressionState: progressionState,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 200.calc),
                Text(
                  config.title,
                  style: TextStyle(
                    color: CustomColors.yellow,
                    fontWeight: FontWeight.w600,
                    fontSize: 36.calc,
                  ),
                ),
                SizedBox(
                  width: 400.calc,
                  child: Text(
                    config.subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: AppDimensions.letterSpacing22,
                      height: AppDimensions.lineHeight,
                      color: CustomColors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 22.calc,
                    ),
                  ),
                ),
                SizedBox(height: 27.calc),
                _Button(
                  onTap: onTap,
                  title: config.buttonTitle,
                  iconPath: config.buttonIconPath,
                  isEnabled: config.isEnabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final String imagePath;
  final BattlePassProgressionState progressionState;

  const _Background({
    required this.imagePath,
    required this.progressionState,
  });

  @override
  Widget build(BuildContext context) {
    final isFree = progressionState == BattlePassProgressionState.free;

    return Center(
      child: Padding(
        padding: isFree ? EdgeInsets.zero : EdgeInsets.only(bottom: 50.calc),
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
      onTap: onTap,
      child: Container(
        width: 400.calc,
        height: 100.calc,
        decoration: BoxDecoration(
          boxShadow: [
            if (isEnabled)
              BoxShadow(
                color: CustomColors.yellowShadow,
                blurRadius: 41.5.calc,
                offset: const Offset(0, 0),
              ),
          ],
          borderRadius: BorderRadius.circular(AppDimensions.radius30),
          gradient: isEnabled
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: CustomColors.yellowGradient1,
                )
              : null,
          color: isEnabled ? null : CustomColors.white10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              CustomSvgPicture(
                iconPath: iconPath,
                color: CustomColors.brown,
                width: 36.calc,
                height: 36.calc,
              ),
              SizedBox(width: 24.calc),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: isEnabled ? 30.calc : 22.calc,
                height: AppDimensions.lineHeight,
                letterSpacing: AppDimensions.letterSpacing22,
                color: isEnabled ? CustomColors.brown : CustomColors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentConfig {
  final String imagePath;
  final String title;
  final String subTitle;
  final String buttonTitle;
  final String? buttonIconPath;
  final bool isEnabled;

  const _ContentConfig({
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.buttonTitle,
    required this.buttonIconPath,
    required this.isEnabled,
  });
}
