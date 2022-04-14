// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todo_list_provider/app/models/task_model.dart';
import 'package:flutter_todo_list_provider/app/models/tasks_filter_enum.dart';
import 'package:flutter_todo_list_provider/app/models/total_tasks_model.dart';
import 'package:flutter_todo_list_provider/app/models/week_tasks_model.dart';
import 'package:flutter_todo_list_provider/app/sevices/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  var filterSelected = TaskFilterEnum.today;

  TotalTasksModel? todayTotalTasks;
  TotalTasksModel? tomorrowTotalTasks;
  TotalTasksModel? weekTotalTasks;
  List<TasksModel> allTasks = [];
  List<TasksModel> filteredTasks = [];

  HomeController({required TasksService tasksService})
      : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getToMorrow(),
      _tasksService.getWeek()
    ]);

    final todayTasks = allTasks[0] as List<TasksModel>;
    final tomorrowasks = allTasks[1] as List<TasksModel>;
    final weekTasks = allTasks[2] as WeekTasksModel;

    todayTotalTasks = TotalTasksModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((Task) => Task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksModel(
      totalTasks: tomorrowasks.length,
      totalTasksFinish: tomorrowasks.where((Task) => Task.finished).length,
    );

    weekTotalTasks = TotalTasksModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((Task) => Task.finished).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TasksModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getToMorrow();
        break;
      case TaskFilterEnum.week:
        final WeekTasksModel = await _tasksService.getWeek();
        tasks = WeekTasksModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    hideLoading();
    notifyListeners();
  }
}
