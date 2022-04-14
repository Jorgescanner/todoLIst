import 'package:flutter_todo_list_provider/app/models/task_model.dart';
import 'package:flutter_todo_list_provider/app/models/week_tasks_model.dart';

abstract class TasksService {
  Future<void> save(DateTime date, String description);

  Future<List<TasksModel>> getToday();
  Future<List<TasksModel>> getToMorrow();
  Future<WeekTasksModel> getWeek();
}
