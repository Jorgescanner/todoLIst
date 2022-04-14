import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:flutter_todo_list_provider/app/core/ui/messages.dart';
import 'package:flutter_todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:flutter_todo_list_provider/app/core/widget/todo_lista_field.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/login/login_%20controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
      context: context,
      everKallBack: (notifier, listenerInstance) {
        if (notifier is LoginController) {
          if (notifier.hasInfo) {
            Messages.of(context).showInfo(notifier.infoMessage!);
          }
        }
      },
      successCallBack: (notifier, listenerInstance) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TodoListLogo(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TodoListaField(
                                  label: 'e-mail',
                                  controller: _emailEC,
                                  focusNode: _emailFocus,
                                  validator: Validatorless.multiple([
                                    Validatorless.required(
                                        'E-mail Obrigatorio!'),
                                    Validatorless.email('e-mail inválido!')
                                  ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TodoListaField(
                                  label: 'Senha',
                                  controller: _passwordEC,
                                  obscureText: true,
                                  validator: Validatorless.multiple([
                                    Validatorless.required(
                                        'Senha obrigatória!'),
                                    Validatorless.min(
                                        6, 'Senha deve ter 6 caracteres!'),
                                  ]),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            if (_emailEC.text.isNotEmpty) {
                                              context
                                                  .read<LoginController>()
                                                  .forgotPassword(
                                                      _emailEC.text);
                                            } else {
                                              _emailFocus.requestFocus();
                                              Messages.of(context).showError(
                                                  'Digite uma email para recuperar senha !');
                                            }
                                          },
                                          child: const Text(
                                            'Esqueceu a senha?',
                                          )),
                                      ElevatedButton(
                                        onPressed: () {
                                          final formValid = _formKey
                                                  .currentState
                                                  ?.validate() ??
                                              false;
                                          if (formValid) {
                                            final email = _emailEC.text;
                                            final password = _passwordEC.text;
                                            context
                                                .read<LoginController>()
                                                .login(email, password);
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Entrar'),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: const Color(0xff5C77CE),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffF0F3F7),
                        border: Border(
                          top: BorderSide(
                            width: 2,
                            color: Colors.grey.withAlpha(50),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          SignInButton(Buttons.Google,
                              text: 'Continue com Google',
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ), onPressed: () {
                            context.read<LoginController>().googleLogin();
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(' nao tem conta ?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/register');
                                },
                                child: const Text('Cadastre-se'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
