import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/ui/kit/colors.dart';
import 'package:matreshka_test_task/ui/pages/battle_pass/page.dart';
import 'package:matreshka_test_task/ui/pages/empty/page.dart';
import 'package:matreshka_test_task/ui/pages/home/components/components.dart';
import 'package:matreshka_test_task/ui/pages/home/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = const [
    EmptyPage(title: 'Screen 1'),
    BattlePassPage(),
    EmptyPage(title: 'Screen 3'),
    EmptyPage(title: 'Screen 4'),
    EmptyPage(title: 'Screen 5'),
    EmptyPage(title: 'Screen 6'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: Stack(
          children: [
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) => pages[state.index],
            ),
            HomePageNavBar(),
          ],
        ),
      ),
    );
  }
}
