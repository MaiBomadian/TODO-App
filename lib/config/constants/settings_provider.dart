import 'package:flutter/material.dart';
import 'package:todo_app/features/settings/pages/settings_view.dart';
import 'package:todo_app/features/tasks/pages/tasks_view.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  int currentIndex = 0;
  String currentLanguage = 'en';
  List<Widget> screens = [
     TasksView(),
    SettingsView(),
  ];

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  changeLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }
}