import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/constants/settings_provider.dart';

class CustomTaskItem extends StatelessWidget {
  const CustomTaskItem({
    super.key,
  });

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
            width: 4,
            height: 62,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Play basket ball',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
                    '10:30 AM',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
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
