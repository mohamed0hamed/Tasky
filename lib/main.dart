import 'package:flutter/material.dart';
import 'package:tasky_app/core/services/preference_manager.dart';
import 'package:tasky_app/core/theme/dark_theme.dart';
import 'package:tasky_app/core/theme/light_theme.dart';
import 'package:tasky_app/core/theme/theme_controller.dart';
import 'package:tasky_app/features/navigation/main_screen.dart';
import 'package:tasky_app/features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceManager().init();
  ThemeController().init();

  String? userName = PreferenceManager().getString('fullName');

  runApp(TaskyApp(fullName: userName));
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key, this.fullName});
  final String? fullName;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          debugShowCheckedModeBanner: false,
          home: fullName == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
