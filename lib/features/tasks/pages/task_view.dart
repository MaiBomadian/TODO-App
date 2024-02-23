import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/task_item.dart';

class TasksView extends StatefulWidget {
  const TasksView({Key? key}) : super(key: key);

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
    return Column(children: [
      Stack(
        alignment: const Alignment(0, 2.0),
        clipBehavior: Clip.none,
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
          EasyInfiniteDateTimeLine(
            dayProps: EasyDayProps(
              height: 90,
              width: 60,
              todayStyle: DayStyle(
                dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
                dayStrStyle: theme.textTheme.displayLarge?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                monthStrStyle: theme.textTheme.displayLarge?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: vm.isDark() ? const Color(0xff141922) : Colors.white,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
              ),
              activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: theme.primaryColor,
                border: Border.all(
                  color: Colors.black,
                ),
              )),
              inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: vm.isDark() ? const Color(0xff141922) : Colors.white,
                  ),
                  dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  )),
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
        height: 50,
      ),
      Expanded(
        child: ListView(
          children: const [
            CustomTaskItem(),
            CustomTaskItem(),
            CustomTaskItem(),
            CustomTaskItem(),
            CustomTaskItem(),
            CustomTaskItem(),
          ],
        ),
      )
    ]);
  }
}
