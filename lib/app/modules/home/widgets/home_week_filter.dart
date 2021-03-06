import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:flutter_todo_list_provider/app/models/tasks_filter_enum.dart';
import 'package:flutter_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
          (controller) => controller.filterSelected == TaskFilterEnum.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text('DIA DA SEMANA', style: context.titleStyle),
          const SizedBox(height: 10.0),
          // ignore: sized_box_for_whitespace
          Container(
            height: 100,
            child: DatePicker(
              DateTime.now(),
              locale: 'pt_BR',
              initialSelectedDate: DateTime.now(),
              selectionColor: context.primaryColor,
              selectedTextColor: Colors.white,
              daysCount: 7,
              monthTextStyle: const TextStyle(fontSize: 8),
              dayTextStyle: const TextStyle(fontSize: 13),
              dateTextStyle: const TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
