// ignore_for_file: file_names

import 'package:flutter_todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todo_list_provider/app/exception/auth_exception.dart';

import 'package:flutter_todo_list_provider/app/sevices/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  bool get hasInfo => infoMessage != null;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.googleLogin();
      if (user != null) {
        success();
      } else {
        setError('Erro ao realizar Login com Google !');
      }
    } on AuthException catch (e) {
      _userService.logout;
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuáio ou senha inválidos!');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  void forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = 'Reset de senha inviado para seu enail !';
    } on Exception catch (e) {
      if (e is AuthException) {
        setError(e.message);
      } else {
        setError('Erro ao resetar a Senha!');
      }
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
