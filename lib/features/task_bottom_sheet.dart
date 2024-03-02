import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/constants/settings_provider.dart';
import 'package:todo_app/core/services/snack_bar_services.dart';
import 'package:todo_app/core/services/firebase_services.dart';
import 'package:todo_app/models/task_model.dart';

import '../core/widgets/text_form_field.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingsProvider>(context);

    return Container(
      width: mediaQuery.width,
      padding: const EdgeInsets.only(top: 20, left: 14, right: 14),
      decoration: BoxDecoration(
        color: vm.isDark() ? const Color(0xff141922) : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new Task',
              style:
                  TextStyle(color: vm.isDark() ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextFormField(
              controller: titleController,
              hintText: 'enter your task title',
              hintColor:Colors.grey.shade600,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              controller: descriptionController,
              hintText: 'enter your description',
              hintColor: Colors.grey.shade600,
              maxLines: 3,
              maxLength: 200,
              onValidate: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Select Time',
              style: theme.textTheme.bodyLarge?.copyWith(color:vm.isDark()? const Color(0xffC3C3C3):Colors.black),

            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                vm.selectedTaskDate(context);
              },
              child: Text(
                DateFormat.yMMMMd().format(vm.selectedDate),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var data = TaskModel(
                    isDone: false,
                    title: titleController.text,
                    description: descriptionController.text,
                    dateTime: vm.selectedDate,
                  );
                  EasyLoading.show();
                  FirebaseService().addNewTasks(data).then((value) {
                    EasyLoading.dismiss();
                    Navigator.of(context).pop();
                  }).onError((error, stackTrace) {
                    EasyLoading.dismiss();
                  });
                }
              },
              child: Text(
                'Add Task',
                textAlign: TextAlign.center,
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
