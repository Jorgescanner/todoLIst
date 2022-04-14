import 'package:flutter_todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/register/register_page.dart';
import 'package:flutter_todo_list_provider/app/modules/todo_list_module.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/login_%20controller.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/login_page.dart';
import 'package:provider/provider.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => LoginController(userService: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) =>
                  RegisterController(userService: context.read()),
            )
          ],
          routers: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
        );
}
