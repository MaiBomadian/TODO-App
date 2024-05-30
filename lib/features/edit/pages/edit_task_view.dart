import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/firebase_services.dart';
import 'package:todo_app/core/widgets/text_form_field.dart';
import 'package:todo_app/models/task_model.dart';
import '../../../core/config/constants/page_routes.dart';
import '../../../core/config/constants/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskView extends StatefulWidget {
  const EditTaskView({super.key});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var taskModel = ModalRoute.of(context)?.settings.arguments as TaskModel;
  var  locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: mediaQuery.height * .2,
              width: mediaQuery.width,
              color: theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 60),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.popAndPushNamed(
                          context,PageRoutesName.layout),
                    ),
                    Text(
                     locale.todolist,
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(25),
              color: vm.isDark() ? const Color(0xff141922) : Colors.white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        locale.editYourTask,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: vm.isDark() ? Colors.white : Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFormField(
                      initValue: taskModel.title,
                      onChanged: (value) {
                        taskModel.title = value!;
                      },
                      hintText: locale.enterYourTaskTitle,
                      hintColor: Colors.grey.shade600,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      initValue: taskModel.description,
                      onChanged: (value) {
                        taskModel.description = value!;
                      },
                      hintText: locale.enterYourTaskDescription,
                      hintColor: Colors.grey.shade600,
                      maxLines: 3,
                      maxLength: 200,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      locale.selectTime,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: vm.isDark()
                              ? const Color(0xffC3C3C3)
                              : Colors.black),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        vm.selectedTaskDate(context);
                        // taskModel.dateTime = await selectedTaskDate(
                        //     context, taskModel.dateTime);
                        // setState(() {});
                        // // vm.selectedTaskDate(context);
                        // // taskModel.dateTime = await selectDateTime(
                        // //     context, taskModel.dateTime as int);
                        // // setState(() {});
                      },
                      child: Text(
                        DateFormat.yMMMMd().format(taskModel.dateTime),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          FirebaseService().updateTask(taskModel);
                          Navigator.popAndPushNamed(
                              context,
                              PageRoutesName.layout); // FirebaseService().updateTask(arguments);
                        },
                        child: Text(
                          locale.saveChanges,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// selectDateTime(BuildContext context, int dateTime) async {
//   DateTime? currentSelectDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.fromMillisecondsSinceEpoch(dateTime),
//     firstDate: DateTime.now(),
//     lastDate: DateTime.now().add(
//       const Duration(days: 365),
//     ),
//   );
//   dateTime = DateUtils.dateOnly(currentSelectDate!).millisecondsSinceEpoch;
// }

// selectedTaskDate(BuildContext context, DateTime dateTime) async {
//   var currentSelectedDate = await showDatePicker(
//     context: context,
//     firstDate: DateTime.now(),
//     initialDate: DateTime.fromMillisecondsSinceEpoch(dateTime as int),
//     currentDate: DateTime.now(),
//     lastDate: DateTime.now().add(
//       const Duration(days: 365),
//     ),
//   );
//   dateTime = DateUtils.dateOnly(currentSelectedDate!).millisecondsSinceEpoch as DateTime;
// }
}
