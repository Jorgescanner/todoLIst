import 'package:flutter/material.dart';
import 'package:flutter_todo_list_provider/app/core/ui/todo_list_icon_icons.dart';

class TodoListaField extends StatelessWidget {
  final String label;
  final IconButton? suffixButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTexeVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  TodoListaField({
    Key? key,
    required this.label,
    this.suffixButton,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode,
  })  : assert(obscureText == true ? suffixButton == null : true,
            'Obscurtext não pode ser enviado em conjunto com IconButon'),
        obscureTexeVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTexeVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          obscureTexeVN.value = !obscureTextValue;
                        },
                        icon: Icon(
                          !obscureTextValue
                              ? TodoListIcon.eyeSlash
                              : TodoListIcon.eye,
                          size: 25,
                        ),
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
