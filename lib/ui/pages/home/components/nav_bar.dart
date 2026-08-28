import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/ui/kit/app_dimensions.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/kit/images.dart';
import 'package:matreshka_test_task/ui/kit/svg_icons.dart';
import 'package:matreshka_test_task/ui/pages/home/components/components.dart';
import 'package:matreshka_test_task/ui/pages/home/cubit/home_cubit.dart';
import 'package:matreshka_test_task/ui/pages/home/models/nav_bar_element.dart';

class HomePageNavBar extends StatelessWidget {
  const HomePageNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: CustomColors.purple,
          image: DecorationImage(
            image: AssetImage(ImagesAssets.sideBar),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          right: false,
          child: SizedBox(
            width: AppDimensions.navBarWidth,
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Center(
                  child: Column(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _elements
                        .map(
                          (e) => HomePageIcon(
                            iconPath: e.iconPath,
                            title: e.title,
                            isActive: state.index == _elements.indexOf(e),
                            isUnread: e.isUnread,
                            onTap: () {
                              context.read<HomeCubit>().changeTab(_elements.indexOf(e));
                            },
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

final _elements = [
  NavBarElement(
    iconPath: SvgIconsAssets.halloween,
    title: 'Ивент',
    isUnread: false,
  ),
  NavBarElement(
    iconPath: SvgIconsAssets.coctail,
    title: 'Battle pass',
    isUnread: false,
  ),
  NavBarElement(
    iconPath: SvgIconsAssets.calendar1,
    title: 'Календарь новичка',
    isUnread: true,
  ),
  NavBarElement(
    iconPath: SvgIconsAssets.calendar2,
    title: 'После уроков',
    isUnread: false,
  ),
  NavBarElement(
    iconPath: SvgIconsAssets.personPlus,
    title: 'Пригласи друга',
    isUnread: false,
  ),
  NavBarElement(
    iconPath: SvgIconsAssets.ticket,
    title: 'Промокод',
    isUnread: false,
  ),
];
