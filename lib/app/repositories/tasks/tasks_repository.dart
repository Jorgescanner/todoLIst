import 'package:flutter_todo_list_provider/app/models/task_model.dart';

abstract class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TasksModel>> findByPeriod(DateTime start, DateTime end);
}
