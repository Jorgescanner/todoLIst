// ignore_for_file: file_names

import 'package:flutter_todo_list_provider/app/core/database/sqlite_conection_factory.dart';
import 'package:flutter_todo_list_provider/app/models/task_model.dart';
import 'package:flutter_todo_list_provider/app/repositories/tasks/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConectionFactory _sqlConnectionFatory;

  TasksRepositoryImpl({required SqliteConectionFactory sqliteConectionFactory})
      : _sqlConnectionFatory = sqliteConectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqlConnectionFatory.openConnection();
    await conn?.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0
    });
  }

  @override
  Future<List<TasksModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endfilter = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _sqlConnectionFatory.openConnection();
    final result = await conn?.rawQuery(
      ''' select * from todo  
      where data_hora between ? and ? 
      order by  data_hora ''',
      [
        startFilter.toIso8601String(),
        endfilter.toIso8601String(),
      ],
    );
    return result!.map((e) => TasksModel.loadFromDB(e)).toList();
  }
}
