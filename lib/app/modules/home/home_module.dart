// ignore: implementation_imports
import 'package:flutter_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter_todo_list_provider/app/modules/home/home_page.dart';
import 'package:flutter_todo_list_provider/app/modules/todo_list_module.dart';
import 'package:flutter_todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:flutter_todo_list_provider/app/sevices/tasks/tasks_service.dart';
import 'package:flutter_todo_list_provider/app/sevices/tasks/tasks_service_impl.dart';
import 'package:provider/provider.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
              create: (context) => TasksRepositoryImpl(
                sqliteConectionFactory: context.read(),
              ),
            ),
            Provider<TasksService>(
              create: (context) => TasksServiceImpl(
                tasksRepository: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => HomeController(
                tasksService: context.read(),
              ),
            )
          ],
          routers: {
            '/home': (context) => HomePage(
                  homeController: context.read(),
                ),
          },
        );
}
