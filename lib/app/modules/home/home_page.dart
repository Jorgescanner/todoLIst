import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:flutter_todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:flutter_todo_list_provider/app/core/ui/todo_list_icon_icons.dart';
import 'package:flutter_todo_list_provider/app/models/tasks_filter_enum.dart';
import 'package:flutter_todo_list_provider/app/modules/home/home_controller.dart';
import 'package:flutter_todo_list_provider/app/modules/home/home_header.dart';
import 'package:flutter_todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:flutter_todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:flutter_todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:flutter_todo_list_provider/app/modules/home/widgets/home_week_filter.dart';
import 'package:flutter_todo_list_provider/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {
  final HomeController _homeController;

  const HomePage({Key? key, required HomeController homeController})
      : _homeController = homeController,
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._homeController).listener(
      context: context,
      successCallBack: (notifier, listenerInstance) {
        listenerInstance.dispose();
      },
    );

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget._homeController.loadTotalTasks();
      widget._homeController.findTasks(filter: TaskFilterEnum.today);
    });
  }

  void _gotoCreateTasks(BuildContext context) {
    //   Navigator.of(context).pushNamed('/tasks/create');
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(microseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TasksModule().getPage('/tasks/create', context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: context.primaryColor,
        ),
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(TodoListIcon.filter),
            itemBuilder: (_) => [
              const PopupMenuItem<bool>(
                child: Text('Mostrar Tarefas concluidas !'),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () => _gotoCreateTasks(context),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeekFilter(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
