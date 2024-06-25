import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/config/constants/page_routes.dart';
import '../../../../core/config/constants/settings_provider.dart';
import '../../../core/services/firebase_services.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final List<String> language = ['English', 'عربي'];
  final List<String> themeList = [
    'Light',
    'Dark',
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var locale =AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: mediaQuery.height * .2,
          width: mediaQuery.width,
          color: theme.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 51, vertical: 60),
            child: Text(
              locale.settings,
              style: theme.textTheme.titleLarge,
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 38, top: 20, bottom: 20, right: 30),
          child: Text(
           locale.language,
            style: theme.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 40),
          child: CustomDropdown(
            initialItem: vm.currentLanguage == 'en' ? 'English' : 'عربي',
            items: language,
            onChanged: (value) {
              if (value == 'English') {
                vm.changeLanguage('en');
              } else if (value == 'عربي') {
                vm.changeLanguage('ar');
              }
            },
            decoration: CustomDropdownDecoration(
              closedBorder: Border.all(color: theme.primaryColor),
              listItemStyle: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.primaryColor),
              headerStyle: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.primaryColor),
              closedBorderRadius: BorderRadius.zero,
              expandedBorderRadius: BorderRadius.zero,
              closedFillColor: vm.currentTheme == ThemeMode.dark
                  ? const Color(0xff141922)
                  : Colors.white,
              expandedFillColor: vm.currentTheme == ThemeMode.dark
                  ? const Color(0xff141922)
                  : Colors.white,
              closedSuffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: vm.currentTheme == ThemeMode.light
                    ? theme.primaryColor
                    : Colors.black,
              ),
              expandedSuffixIcon:
                  Icon(Icons.keyboard_arrow_up, color: theme.primaryColor),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 38, top: 20, bottom: 20, right: 30),
          child: Text(
            locale.mode,
            style: theme.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 40),
          child: CustomDropdown(
            initialItem: vm.currentTheme == ThemeMode.dark ? 'Dark' : 'Light',

            decoration: CustomDropdownDecoration(

              closedBorder: Border.all(color: theme.primaryColor),
              listItemStyle: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.primaryColor),
              headerStyle: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.primaryColor),
              closedFillColor: vm.currentTheme == ThemeMode.dark
                  ? const Color(0xff141922)
                  : Colors.white,
              expandedFillColor: vm.currentTheme == ThemeMode.dark
                  ? const Color(0xff141922)
                  : Colors.white,
              closedBorderRadius: BorderRadius.zero,
              expandedBorderRadius: BorderRadius.zero,
              closedSuffixIcon: Icon(
                Icons.keyboard_arrow_down,
                color: vm.currentTheme == ThemeMode.light
                    ? theme.primaryColor
                    : Colors.black,
              ),
              expandedSuffixIcon: Icon(
                Icons.keyboard_arrow_up,
                color: theme.primaryColor,
              ),
            ),
            items: themeList,
            onChanged: (value) {
              if (value == 'Dark') {
                vm.changeTheme(ThemeMode.dark);
              } else if (value == 'Light') {
                vm.changeTheme(ThemeMode.light);
              }
            },
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              FirebaseService().signOut();
              EasyLoading.dismiss();
                Navigator.pushReplacementNamed(context, PageRoutesName.login);
                vm.clear();
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 24),
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  locale.signOut,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        ],
    );
  }
}
