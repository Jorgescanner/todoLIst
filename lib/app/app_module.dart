import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_todo_list_provider/app/app_widget.dart';
import 'package:flutter_todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:flutter_todo_list_provider/app/core/database/sqlite_conection_factory.dart';
import 'package:flutter_todo_list_provider/app/repositories/user/user_repository.dart';
import 'package:flutter_todo_list_provider/app/repositories/user/user_repository_impl.dart';
import 'package:flutter_todo_list_provider/app/sevices/user/user_service.dart';
import 'package:flutter_todo_list_provider/app/sevices/user/user_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConectionFactory(),
          lazy: false,
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(firebaseAuth: context.read()),
        ),
        Provider<UserService>(
            create: (context) =>
                UserServicempl(userRepository: context.read())),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            firebaseAuth: context.read(),
            userService: context.read(),
          )..loadlistener(),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
