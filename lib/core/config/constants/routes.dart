import 'package:flutter/material.dart';
import 'package:todo_app/core/config/constants/page_routes.dart';
import 'package:todo_app/features/register/pages/register_view.dart';

import '../../../features/edit/pages/edit_task_view.dart';
import '../../../features/layout_view.dart';
import '../../../features/login/pages/login_view.dart';
import '../../../features/settings/pages/settings_view.dart';
import '../../../features/splash/pages/splash_view.dart';

class Routes {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case PageRoutesName.splash:
        return MaterialPageRoute(
          builder: (context) => SplashView(),
          settings: settings,
        );
      case PageRoutesName.layout:
        return MaterialPageRoute(
          builder: (context) => const LayoutView(),
          settings: settings,
        );
      case PageRoutesName.login:
        return MaterialPageRoute(
          builder: (context) =>  LoginView(),
          settings: settings,
        );
      case PageRoutesName.registration:
        return MaterialPageRoute(
          builder: (context) =>  RegisterView(),
          settings: settings,
        );
      case PageRoutesName.edit :
        return MaterialPageRoute(
          builder: (context) =>  const EditTaskView(),
          settings: settings,
        );
      case PageRoutesName.settings:
        return MaterialPageRoute(
          builder: (context) =>   SettingsView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
    }
  }
}
