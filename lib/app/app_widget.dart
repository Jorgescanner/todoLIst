// ignore_for_file: unused_import

//nativos
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//terceiros
import 'package:firebase_auth/firebase_auth.dart';
//locais
import 'package:flutter_todo_list_provider/app/core/database/sqli_adm_connection.dart';
import 'package:flutter_todo_list_provider/app/core/navigator/todo_list_navigator.dart';
import 'package:flutter_todo_list_provider/app/core/ui/todo_list_ui_configui.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/auth_module.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:flutter_todo_list_provider/app/modules/home/home_module.dart';
import 'package:flutter_todo_list_provider/app/modules/home/home_page.dart';
import 'package:flutter_todo_list_provider/app/modules/splash/splash_page.dart';
import 'package:flutter_todo_list_provider/app/modules/tasks/tasks_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqlAdmCconnection = SqliAdmConnection();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(sqlAdmCconnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(sqlAdmCconnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      theme: TodoListUiConfigui.theme,
      debugShowCheckedModeBanner: false,
      navigatorKey: TodoListNavigator.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      //   initialRoute: '/login',
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TasksModule().routers,
      },
      home: const SplashPage(),
    );
  }
}
