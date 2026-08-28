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
import 'package:matreshka_test_task/ui/pages/tasks/page.dart';

class BattlePassPageTasks extends StatefulWidget {
  const BattlePassPageTasks({super.key});

  @override
  State<BattlePassPageTasks> createState() => _BattlePassPageTasksState();
}

class _BattlePassPageTasksState extends State<BattlePassPageTasks> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    context.read<BattlePassCubit>().changeTasksIndex(index);
  }

  void _selectPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppDimensions.navBarWidth + MediaQuery.viewPaddingOf(context).left + 51.calc,
      top: 220.calc,
      child: Column(
        children: [
          const _TopContainer(),

          Container(
            width: 400.calc,
            height: 290.calc,
            decoration: BoxDecoration(
              color: CustomColors.gray3.withValues(alpha: 0.6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppDimensions.radius30),
                bottomRight: Radius.circular(AppDimensions.radius30),
              ),
            ),
            child: BlocBuilder<BattlePassCubit, BattlePassState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: .spaceEvenly,
                  children: [
                    SizedBox(
                      width: 340.calc,
                      height: 70.calc,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: state.tasks.length,
                        onPageChanged: _onPageChanged,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              state.tasks[index].description,
                              textAlign: .center,
                              style: TextStyle(
                                color: CustomColors.white60,
                                fontWeight: .w500,
                                fontSize: 22.calc,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    Row(
                      mainAxisAlignment: .center,
                      children: state.tasks.map((e) {
                        final isActive = state.tasks.indexOf(e) == state.tasksPickedIndex;

                        return GestureDetector(
                          onTap: () => _selectPage(state.tasks.indexOf(e)),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            margin: EdgeInsets.symmetric(
                              horizontal: 6.calc,
                            ),
                            width: 50.calc,
                            height: 8.calc,
                            decoration: BoxDecoration(
                              color: isActive ? CustomColors.white100 : CustomColors.white10,
                              borderRadius: BorderRadius.circular(10.calc),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const _Button(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TasksPage(),
          ),
        );
      },
      child: Container(
        width: 320.calc,
        height: 74.calc,
        decoration: BoxDecoration(
          color: CustomColors.white10,
          borderRadius: BorderRadius.circular(
            AppDimensions.radius30,
          ),
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
    );
  }
}

class _TopContainer extends StatelessWidget {
  const _TopContainer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BattlePassCubit, BattlePassState>(
      builder: (context, state) {
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
              const CustomImageAsset(
                assetPath: ImagesAssets.xp,
              ),
              SizedBox(width: 12.calc),
              Text(
                'x ${state.tasks[state.tasksPickedIndex].exp}',
                style: TextStyle(
                  color: CustomColors.white100,
                  fontSize: 26.calc,
                  height: 1.2,
                  letterSpacing: -0.22,
                ),
              ),
              const Spacer(),
              Container(
                width: 112.calc,
                height: 56.calc,
                decoration: BoxDecoration(
                  color: CustomColors.dominant,
                  borderRadius: BorderRadius.circular(20.calc),
                ),
                child: Visibility(
                  visible: state.tasks[state.tasksPickedIndex].isComplete,
                  replacement: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 26.calc,
                          fontWeight: .w500,
                        ),
                        children: [
                          TextSpan(
                            text: '${state.tasksPickedIndex + 1}',
                            style: const TextStyle(
                              color: CustomColors.green,
                            ),
                          ),
                          TextSpan(
                            text: ' / ${state.tasks.length}',
                            style: const TextStyle(
                              color: CustomColors.gray4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: CustomSvgPicture(
                    iconPath: SvgIconsAssets.done,
                    width: 38.calc,
                    height: 38.calc,
                    color: CustomColors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
