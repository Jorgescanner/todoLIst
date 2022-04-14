import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:flutter_todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Selector<AuthProvider, String>(
          selector: (context, authProvaider) =>
              authProvaider.user?.displayName ?? 'NÃO Informado!',
          builder: (_, value, __) {
            return Text(
              'E ai, $value!',
              style: context.textheme.headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            );
          }),
    );
  }
}
