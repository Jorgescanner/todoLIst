import 'package:flutter_todo_list_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:flutter_todo_list_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:flutter_todo_list_provider/app/modules/todo_list_module.dart';
import 'package:flutter_todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_todo_list_provider/app/repositories/tasks/tasks_repository_Impl.dart';
import 'package:flutter_todo_list_provider/app/sevices/tasks/tasks_service.dart';
import 'package:flutter_todo_list_provider/app/sevices/tasks/tasks_service_impl.dart';
import 'package:provider/provider.dart';

class TasksModule extends TodoListModule {
  TasksModule()
      : super(bindings: [
          Provider<TasksRepository>(
            create: (context) =>
                TasksRepositoryImpl(sqliteConectionFactory: context.read()),
          ),
          Provider<TasksService>(
            create: (context) =>
                TasksServiceImpl(tasksRepository: context.read()),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                TasksCreateController(tasksService: context.read()),
          ),
        ], routers: {
          '/tasks/create': (context) => TasksCreatePage(
                controller: context.read(),
              ),
        });
}
