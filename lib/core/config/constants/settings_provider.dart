import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    if (currentSelectedDate == null) return;
    selectedDate = currentSelectedDate;
    notifyListeners();
  }

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  Future changeTheme(ThemeMode newTheme) async {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsDark', newTheme == ThemeMode.dark);
  }

  Future <void>getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? theme = prefs.getBool('IsDark');
    if (theme != null) {
      if (theme) {
        currentTheme = ThemeMode.dark;
      } else {
        currentTheme = ThemeMode.light;
      }
      notifyListeners();
    }
  }

  Future changeLanguage(String newLanguage) async {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
  }

  Future<void> getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    if (language != null) {
      currentLanguage = language;
      notifyListeners();
    }
  }

  bool isDark() {
    return currentTheme == ThemeMode.dark;
  }
}
