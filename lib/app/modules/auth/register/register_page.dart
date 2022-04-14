import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:flutter_todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:flutter_todo_list_provider/app/core/validators/validators.dart';
import 'package:flutter_todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:flutter_todo_list_provider/app/core/widget/todo_lista_field.dart';
import 'package:flutter_todo_list_provider/app/modules/auth/register/register_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmePasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmePasswordEC;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());
    defaultListener.listener(
        context: context,
        successCallBack: (notifier, listernerInstance) {
          listernerInstance.dispose();
        });

    // context.read<RegisterController>().addListener(() {});
    // final controlller = context.read<RegisterController>();
    // var sucess = controlller.isSuccess;
    // var error = controlller.error;
    // if (sucess) {
    //   Navigator.of(context).pop();
    // } else if (error != null && error.isNotEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(error),
    //     backgroundColor: Colors.red,
    //   ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 10, color: context.primaryColor),
            ),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: context.primaryColor,
                )),
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: const FittedBox(
              child: TodoListLogo(),
              fit: BoxFit.fitHeight,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TodoListaField(
                    label: 'E-mail',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail Obrigatorio!'),
                      Validatorless.email('e-mail inválido!')
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListaField(
                    controller: _passwordEC,
                    label: 'Senha',
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória!'),
                      Validatorless.min(6, 'Senha deve ter 6 caracteres!'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TodoListaField(
                      controller: _confirmePasswordEC,
                      label: 'Confirme a Senha',
                      obscureText: true,
                      validator: Validatorless.multiple(
                        [
                          Validatorless.required('Campo senha é Obrigatório !'),
                          Validatorless.min(
                              6, 'Senha deve ter pelo menos 6 caracteres !'),
                          Validators.compare(
                              _passwordEC, 'Senha diferente de onfirma senha!'),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        final email = _emailEC.text;
                        final password = _passwordEC.text;
                        if (formValid) {
                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Salvar'),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff5C77CE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
