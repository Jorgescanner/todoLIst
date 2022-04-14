import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:flutter_todo_list_provider/app/core/ui/messages.dart';
import 'package:flutter_todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:flutter_todo_list_provider/app/sevices/user/user_service.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  final nameVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                    selector: (context, authProvider) {
                  return authProvider.user?.photoURL ??
                      'https://2img.net/u/2612/28/77/07/avatars/42070-76.png';
                }, builder: (_, value, __) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  );
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider, String>(
                        selector: (context, authProvider) {
                      return authProvider.user?.displayName ?? 'Não informado';
                    }, builder: (_, value, __) {
                      return Text(
                        value,
                        style: context.textheme.subtitle1,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Alterar o Nome'),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                          onPressed: () {
                            final nameVNValue = nameVN.value;
                            if (nameVNValue.isEmpty) {
                              Messages.of(context)
                                  .showError('Nome obrigatório !');
                            } else {
                              context
                                  .read<UserService>()
                                  .updateDisplayName(nameVNValue);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Alterar'),
                        ),
                      ],
                    );
                  });
            },
            title: const Text('Auterar Nome'),
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }
}
