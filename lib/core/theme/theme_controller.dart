import 'package:flutter/material.dart';
import 'package:tasky_app/core/constance/storage_key.dart';
import 'package:tasky_app/core/services/preference_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
   init() {
    bool result = PreferenceManager().getBool(StorageKey.themeMode) ?? true;

    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

   toggle() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
     await PreferenceManager().setBool(StorageKey.themeMode, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferenceManager().setBool(StorageKey.themeMode, true);
    }
  }

  static bool isDark() => ThemeController.themeNotifier.value == ThemeMode.dark; 
}
