import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';

import '../../../core/config/constants/settings_provider.dart';

class CustomTaskItem extends StatelessWidget {
   CustomTaskItem({
    super.key,
    required this.taskModel
  });
  TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 115,
      width: mediaQuery.width,
      decoration: BoxDecoration(
        color: vm.isDark() ? const Color(0xff141922) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 6,
            height: 90,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  taskModel.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  taskModel.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: vm.isDark()? Colors.white: Colors.black,
                  ),),
                Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      color: vm.isDark() ? Colors.white : Colors.black,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      DateFormat.yMMMMd().format(taskModel.dateTime),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.check,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
