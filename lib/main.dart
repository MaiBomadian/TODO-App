import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants/application_theme_manager.dart';
import 'package:todo_app/core/config/constants/settings_provider.dart';
import 'package:todo_app/core/services/loading_service.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/login/pages/login_view.dart';
import 'package:todo_app/features/register/pages/register_view.dart';
import 'package:todo_app/features/splash/pages/splash_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => SettingsProvider(),
    child: const TodoApp(),
  ));
  configLoading();
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
      navigatorObservers: [BotToastNavigatorObserver()],
      locale: Locale(vm.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      themeMode: vm.currentTheme,
      theme: ApplicationThemeManager.lightTheme,
      darkTheme: ApplicationThemeManager.darkTheme,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        LayoutView.routeName: (context) => const LayoutView(),
        LoginView.routeName: (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView(),
      },
    );
  }
}
