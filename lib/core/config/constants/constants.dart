import 'package:flutter/material.dart';

import '../../../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Constants {
  static var theme = Theme.of(navigatorKey.currentState!.context);
  static var mediaQuery =
      MediaQuery.of(navigatorKey.currentState!.context).size;
  static const String baseURL = 'https://route-ecommerce.onrender.com';
}
