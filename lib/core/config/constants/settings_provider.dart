import 'package:flutter/material.dart';
import 'package:todo_app/features/settings/pages/settings_view.dart';

import '../../../features/tasks/pages/task_view.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  int currentIndex = 0;
  String currentLanguage = 'en';
  DateTime selectedDate = DateTime.now();
  List<Widget> screens = [
    const TasksView(),
    SettingsView(),
  ];

  selectedTaskDate(BuildContext context) async {
   var currentSelectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      currentDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
   if(currentSelectedDate == null)return;
   selectedDate = currentSelectedDate;
   notifyListeners();
  }

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
