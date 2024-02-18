import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/constants/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/task_item_widget.dart';

class TasksView extends StatefulWidget {
  TasksView({Key? key}) : super(key: key);

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime focusTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var locale = AppLocalizations.of(context)!;

    return Column(
      children: [
        Stack(
          alignment: const Alignment(0, 2.0),
          clipBehavior: Clip.none,
          children: [
            Container(
              height: mediaQuery.height * .2,
              width: mediaQuery.width,
              color: theme.primaryColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 51, vertical: 60),
                child: Text(
                  locale.todolist,
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            EasyInfiniteDateTimeLine(
              dayProps: EasyDayProps(
                dayStructure: DayStructure.dayStrDayNum,
                height: 90,
                width: 60,
                todayStyle: DayStyle(
                  borderRadius: 0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          vm.isDark() ? const Color(0xff141922) : Colors.white,
                      border: Border.all(color: theme.primaryColor)),
                  dayStrStyle: theme.textTheme.displayLarge?.copyWith(
                    color: theme.primaryColor,
                  ),
                  dayNumStyle: theme.textTheme.displayLarge?.copyWith(
                    color: theme.primaryColor,
                  ),
                  // monthStrStyle: theme.textTheme.displayLarge?.copyWith(
                  //   color: theme.primaryColor,
                  // ),
                ),
                inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10),
                    color: vm.isDark() ? const Color(0xff141922) : Colors.white,
                  ),
                  dayStrStyle: vm.isDark()
                      ? theme.textTheme.displayLarge
                      : theme.textTheme.displayLarge?.copyWith(
                          color: Colors.black54,
                        ),
                  dayNumStyle: vm.isDark()
                      ? theme.textTheme.displayLarge
                      : theme.textTheme.displayLarge?.copyWith(
                          color: Colors.black,
                        ),
                  // monthStrStyle: theme.textTheme.displayLarge
                  //     ?.copyWith(color: Colors.grey.shade400),
                ),
                activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10),
                    color: theme.primaryColor,
                  ),
                  // monthStrStyle: theme.textTheme.displayLarge
                  //     ?.copyWith(color: Colors.grey.shade400),
                ),
              ),
              timeLineProps: const EasyTimeLineProps(
                separatorPadding: 20,
              ),
              showTimelineHeader: false,
              firstDate: DateTime(2024),
              focusDate: focusTime,
              lastDate: DateTime(2025),
              onDateChange: (selectedDate) {
                setState(() {
                  focusTime = selectedDate;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: 45,
        ),
        Expanded(
          child: ListView(
            children: const [
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
              TaskItem(),
            ],
          ),
        )
      ],
    );
  }
}
