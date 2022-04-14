import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:flutter_todo_list_provider/app/models/tasks_filter_enum.dart';
import 'package:flutter_todo_list_provider/app/models/total_tasks_model.dart';
import 'package:flutter_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter_todo_list_provider/app/modules/home/widgets/tot_card_filters.dart';
import 'package:provider/provider.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TotCardFilters(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                        (controller) => controller.todayTotalTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.today,
              ),
              TotCardFilters(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                        (controller) => controller.tomorrowTotalTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.tomorrow,
              ),
              TotCardFilters(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                        (controller) => controller.weekTotalTasks),
                selected: context.select<HomeController, TaskFilterEnum>(
                        (value) => value.filterSelected) ==
                    TaskFilterEnum.week,
              ),
            ],
          ),
        )
      ],
    );
  }
}
