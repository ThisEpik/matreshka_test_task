import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matreshka_test_task/ui/pages/home/page.dart';
import 'package:matreshka_test_task/ui/themes/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomDarkTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
