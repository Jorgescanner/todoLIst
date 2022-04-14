// ignore_for_file: non_constant_identifier_names

import 'package:flutter_todo_list_provider/app/models/task_model.dart';
import 'package:flutter_todo_list_provider/app/models/week_tasks_model.dart';
import 'package:flutter_todo_list_provider/app/repositories/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({
    required TasksRepository tasksRepository,
  }) : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) =>
      _tasksRepository.save(date, description);

  @override
  Future<List<TasksModel>> getToMorrow() {
    return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TasksModel>> getToday() {
    var ToMorrowDate = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(ToMorrowDate, ToMorrowDate);
  }

  @override
  Future<WeekTasksModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.year, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: startFilter.weekday - 1));
    }

    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter);
    return WeekTasksModel(
        startDate: startFilter, endDate: endFilter, tasks: tasks);
  }
}
