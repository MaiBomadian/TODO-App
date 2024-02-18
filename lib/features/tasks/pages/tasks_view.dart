import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/constants/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Container(
          height: mediaQuery.height * .2,
          width: mediaQuery.width,
          color: theme.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 51, vertical: 60),
            child: Text(
              locale.todolist,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),

      ],
    );
  }
}
