import 'package:flutter_todo_list_provider/app/models/task_model.dart';

class WeekTasksModel {
  final DateTime startDate;
  final DateTime endDate;
  final List<TasksModel> tasks;
  WeekTasksModel({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}
