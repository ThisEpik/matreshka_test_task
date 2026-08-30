import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/domain/enums/battle_pass_reward_rarity.dart';
import 'package:matreshka_test_task/domain/enums/battle_pass_reward_status.dart';
import 'package:matreshka_test_task/domain/models/battle_pass_reward.dart';
import 'package:matreshka_test_task/ui/global_components/circle_button.dart';
import 'package:matreshka_test_task/ui/global_components/custom_image_asset.dart';
import 'package:matreshka_test_task/ui/global_components/custom_svg_picture.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/cubit/battle_pass_cubit.dart';

/// Вот тут UI я сам писал, потом решил поиграться с агентом.
/// И логику тут по большей части писал Codex.

class BattlePassPageRewards extends StatefulWidget {
  const BattlePassPageRewards({super.key});

  @override
  State<BattlePassPageRewards> createState() => _BattlePassPageRewardsState();
}

class _BattlePassPageRewardsState extends State<BattlePassPageRewards> {
  final scrollController = ScrollController();

  double get _pinnedRewardAreaWidth => 260.calc;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll(ScrollMetrics metrics) {
    final cubit = context.read<BattlePassCubit>();
    final rewards = cubit.state.rewards;
    final isAtEnd = metrics.extentAfter <= 1;

    cubit.updateRewardsScrollState(
      isAtStart: metrics.pixels <= metrics.minScrollExtent + 1,
      isAtEnd: isAtEnd,
      pinnedRewardIndex: isAtEnd ? _lastPinnedRewardIndex(rewards) : _pinnedRewardIndex(rewards, metrics),
    );
  }

  int? _lastPinnedRewardIndex(List<IBattlePassReward> rewards) {
    if (rewards.isEmpty) {
      return null;
    }

    final lastIndex = rewards.length - 1;

    return _isPinnedMilestone(rewards[lastIndex], lastIndex) ? lastIndex : null;
  }

  int? _pinnedRewardIndex(List<IBattlePassReward> rewards, ScrollMetrics metrics) {
    if (rewards.isEmpty) {
      return null;
    }

    var itemStart = AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + AppDimensions.padding51;
    final viewportEnd = metrics.pixels + metrics.viewportDimension;

    for (var index = 0; index < rewards.length; index++) {
      final itemEnd = itemStart + _rewardItemWidth(rewards[index]);

      if (_isPinnedMilestone(rewards[index], index) && itemStart >= viewportEnd) {
        return index;
      }

      itemStart = itemEnd;
    }

    return null;
  }

  bool _isMilestone(int index) => (index + 1) % 10 == 0;

  bool _isPinnedMilestone(IBattlePassReward reward, int index) {
    return _isMilestone(index) && reward.status == BattlePassRewardStatus.unreached;
  }

  double _rewardItemWidth(IBattlePassReward reward) {
    return reward.status == BattlePassRewardStatus.reached ? 260.calc : 222.calc;
  }

  void _scrollByRewards(int direction) {
    if (!scrollController.hasClients) {
      return;
    }

    final state = context.read<BattlePassCubit>().state;
    final rewardIndices = <int>[
      for (var index = 0; index < state.rewards.length; index++)
        if (index != state.pinnedRewardIndex) index,
    ];

    if (rewardIndices.isEmpty) {
      return;
    }

    final leadingPadding = AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + AppDimensions.padding51;
    final currentOffset = scrollController.offset;
    var itemStart = leadingPadding;
    var currentItemIndex = 0;

    for (var index = 0; index < rewardIndices.length; index++) {
      final itemEnd = itemStart + _rewardItemWidth(state.rewards[rewardIndices[index]]);

      if (currentOffset < itemEnd) {
        currentItemIndex = index;
        break;
      }

      itemStart = itemEnd;
      currentItemIndex = index;
    }

    final targetItemIndex = (currentItemIndex + direction * 10).clamp(0, rewardIndices.length - 1).toInt();
    var targetOffset = leadingPadding;

    for (var index = 0; index < targetItemIndex; index++) {
      targetOffset += _rewardItemWidth(state.rewards[rewardIndices[index]]);
    }

    final isFirstPage = direction < 0 && targetItemIndex == 0;
    final isLastPage = direction > 0 && targetItemIndex >= rewardIndices.length - 10;
    final targetScrollOffset = isFirstPage
        ? scrollController.position.minScrollExtent
        : isLastPage
        ? scrollController.position.maxScrollExtent
        : targetOffset
              .clamp(
                scrollController.position.minScrollExtent,
                scrollController.position.maxScrollExtent,
              )
              .toDouble();

    final scrollAnimation = scrollController.animateTo(
      targetScrollOffset,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );

    if (isLastPage) {
      scrollAnimation.whenComplete(() {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: SizedBox(
        height: 330.calc,
        width: MediaQuery.of(context).size.width,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            _onScroll(notification.metrics);
            return false;
          },
          child: BlocBuilder<BattlePassCubit, BattlePassState>(
            buildWhen: (previous, current) =>
                previous.rewards != current.rewards ||
                previous.isRewardsAtStart != current.isRewardsAtStart ||
                previous.isRewardsAtEnd != current.isRewardsAtEnd ||
                previous.pinnedRewardIndex != current.pinnedRewardIndex,
            builder: (context, state) {
              final pinnedRewardIndex = state.pinnedRewardIndex;
              final visibleRewardIndices = <int>[
                for (var index = 0; index < state.rewards.length; index++)
                  if (index != pinnedRewardIndex) index,
              ];

              return Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: _pinnedRewardAreaWidth,
                    top: 0,
                    bottom: 0,
                    child: ShaderMask(
                      blendMode: BlendMode.dstIn,
                      shaderCallback: (bounds) {
                        final fadeWidth = 400.calc;
                        final maxFade = bounds.width / 2;
                        final leftFade = state.isRewardsAtStart ? 0.0 : (fadeWidth * 1.5).clamp(0.0, maxFade);
                        final rightFade = state.isRewardsAtEnd ? 0.0 : fadeWidth.clamp(0.0, maxFade);

                        return LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.0, leftFade / bounds.width, 1.0 - rightFade / bounds.width, 1.0],
                          colors: const [
                            CustomColors.transparent,
                            CustomColors.white100,
                            CustomColors.white100,
                            CustomColors.transparent,
                          ],
                        ).createShader(bounds);
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: visibleRewardIndices.length,
                        padding: EdgeInsets.only(
                          left:
                              AppDimensions.navBarWidth +
                              MediaQuery.viewPaddingOf(context).left +
                              AppDimensions.padding51,
                          right: AppDimensions.padding51,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final rewardIndex = visibleRewardIndices[index];

                          return _RewardItem(
                            reward: state.rewards[rewardIndex],
                            level: rewardIndex + 1,
                          );
                        },
                      ),
                    ),
                  ),
                  if (pinnedRewardIndex != null)
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      width: _pinnedRewardAreaWidth,
                      child: _RewardItem(
                        reward: state.rewards[pinnedRewardIndex],
                        level: pinnedRewardIndex + 1,
                        displayAsReached: true,
                        showProgressLine: false,
                      ),
                    ),

                  Positioned(
                    left: AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + AppDimensions.padding51,
                    top: 60.calc,
                    child: Opacity(
                      opacity: state.isRewardsAtStart ? 0 : 1,
                      child: CustomCircleButton(
                        onTap: state.isRewardsAtStart ? null : () => _scrollByRewards(-1),
                        iconPath: SvgIconsAssets.chevronLeft,
                      ),
                    ),
                  ),

                  Positioned(
                    right: _pinnedRewardAreaWidth + 20.calc + AppDimensions.padding51,
                    top: 60.calc,
                    child: Opacity(
                      opacity: state.isRewardsAtEnd ? 0 : 1,
                      child: CustomCircleButton(
                        onTap: state.isRewardsAtEnd ? null : () => _scrollByRewards(1),
                        iconPath: SvgIconsAssets.chevronRight,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _RewardItem extends StatelessWidget {
  final IBattlePassReward reward;
  final int level;
  final bool displayAsReached;
  final bool showProgressLine;

  const _RewardItem({
    required this.reward,
    required this.level,
    this.displayAsReached = false,
    this.showProgressLine = true,
  });

  double get cardWidth {
    return displayAsReached || reward.status == BattlePassRewardStatus.reached ? 260.calc : 222.calc;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardWidth,
      child: Stack(
        children: [
          _Reward(
            reward: reward,
            displayAsReached: displayAsReached,
          ),

          if (showProgressLine)
            _ProgressLine(
              isActive: reward.status == BattlePassRewardStatus.reached,
            ),

          Positioned(
            left: (cardWidth / 1.2).calc,
            bottom: 25.calc,
            child: _ProgressPoint(
              level: level,
              isActive: reward.status == BattlePassRewardStatus.reached,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressLine extends StatelessWidget {
  final bool isActive;

  const _ProgressLine({
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 50.calc,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 10.calc,
              decoration: BoxDecoration(
                color: isActive ? CustomColors.red2 : CustomColors.dominant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressPoint extends StatelessWidget {
  final int level;
  final bool isActive;

  const _ProgressPoint({
    required this.level,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.785398,
      child: Container(
        width: 60.calc,
        height: 60.calc,
        decoration: BoxDecoration(
          color: isActive ? CustomColors.red2 : CustomColors.dominant,
          borderRadius: BorderRadius.circular(10.calc),
        ),
        child: Transform.rotate(
          angle: -0.785398,
          child: Center(
            child: Text(
              '$level',
              style: TextStyle(
                fontSize: 22.calc,
                fontWeight: FontWeight.w500,
                color: CustomColors.white100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Reward extends StatelessWidget {
  final IBattlePassReward reward;
  final bool displayAsReached;

  const _Reward({
    required this.reward,
    required this.displayAsReached,
  });

  bool get _isLarge => displayAsReached || reward.status == BattlePassRewardStatus.reached;

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
    return BlocBuilder<BattlePassCubit, BattlePassState>(
      builder: (context, state) {
        late final Color borderColor;

        if (state.pickedReward?.id == reward.id) {
          borderColor = CustomColors.white100;
        } else if (reward.status == BattlePassRewardStatus.reached) {
          borderColor = CustomColors.green;
        } else {
          borderColor = CustomColors.transparent;
        }

        return Center(
          child: GestureDetector(
            onTapDown: (_) {
              context.read<BattlePassCubit>().pickReward(reward);
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..setEntry(0, 1, -0.08)
                ..translateByDouble(-5.0, 0.0, 0.0, 1.0),
              child: Stack(
                children: [
                  Opacity(
                    opacity: reward.isClaimed ? .3 : 1,
                    child: Container(
                      width: _isLarge ? 240.calc : 202.calc,
                      height: _isLarge ? 218.calc : 183.calc,
                      margin: EdgeInsets.only(
                        right: 20.calc,
                        bottom: 110.calc,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radius30,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: gradientColors,
                        ),
                        border: Border.all(
                          color: borderColor,
                          width: 1.5,
                        ),
                        boxShadow: [
                          if (_isLarge)
                            BoxShadow(
                              color: borderColor,
                              blurRadius: 45.1.calc,
                              offset: const Offset(0, 0),
                            ),
                        ],
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
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radius30.calc,
                                  ),
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
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.radius30.calc,
                                  ),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
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
                            bottom: displayAsReached || reward.status != BattlePassRewardStatus.reached
                                ? 10.calc
                                : 80.calc,
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
                                      fontWeight: FontWeight.w500,
                                      color: CustomColors.white100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          if (reward.status == BattlePassRewardStatus.reached && !reward.isClaimed)
                            Align(
                              alignment: Alignment.bottomCenter,
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
                                    margin: EdgeInsets.all(13.calc),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: CustomColors.greenGradient1,
                                      ),
                                      borderRadius: BorderRadius.circular(20.calc),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Забрать',
                                        style: TextStyle(
                                          color: CustomColors.white100,
                                          fontWeight: FontWeight.w500,
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
                        ],
                      ),
                    ),
                  ),

                  if (reward.isClaimed)
                    Positioned(
                      top: 15.calc,
                      right: 35.calc,
                      child: CustomSvgPicture(
                        iconPath: SvgIconsAssets.done,
                        width: 48.calc,
                        height: 48.calc,
                        color: CustomColors.green,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
