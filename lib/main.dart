import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matreshka_test_task/data/repos/battle_pass_repo.dart';
import 'package:matreshka_test_task/domain/repos/battle_pass_repo.dart';
import 'package:matreshka_test_task/ui/helpers/adaptive_sizes.dart';
import 'package:matreshka_test_task/ui/pages/home/page.dart';
import 'package:matreshka_test_task/ui/themes/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IBattlePassRepository>(
          create: (_) => MockBattlePassRepo(),
        ),
      ],
      child: MaterialApp(
        theme: CustomDarkTheme.theme,
        debugShowCheckedModeBanner: false,
        home: const _AdaptiveLayout(child: HomePage()),
      ),
    );
  }
}

/// У меня была проблема, при запуске на реальном устройстве, рассчеты от .calc
/// для адаптивности я получал неверные. Я так понял что это связанно с тем
/// что приложение запускается в портрете, высчитывало значения,
/// затем переключалось в лэндскейп, и строило UI на неверных рассчетах.
/// Этот же объект позволяет перестраивать UI если меняется ориентация.
class _AdaptiveLayout extends StatelessWidget {
  final Widget child;

  const _AdaptiveLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    AdaptiveSize.updateScreenSize(screenSize);

    return KeyedSubtree(
      key: ValueKey(screenSize),
      child: child,
    );
  }
}
