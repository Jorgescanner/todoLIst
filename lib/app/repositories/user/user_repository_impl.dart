import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo_list_provider/app/exception/auth_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    } on FirebaseAuthException catch (e, s) {
      // ignore: avoid_print
      print(e);
      // ignore: avoid_print
      print(s);

      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado por favor escolha outro e-mail');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou not TodoList pelo Google, por favor utilize ele para entrar !!!');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }
      throw AuthException(message: e.message ?? 'Erro ao realizaer Login !');
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Login ou senha inválidos !');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizaer Login !');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final loginMethods =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('Google')) {
        throw AuthException(
            message:
                'Cadastro realizado com Google, não pode ser resetado a senha');
      } else {
        throw AuthException(message: 'email não cadastrado');
      }
    } on PlatformException catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }
      AuthException(message: 'Error ao resetar a senha!');
    }
  }

  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods;
    try {
      final googlesignIn = GoogleSignIn();
      final googleUser = await googlesignIn.signIn();
      if (googleUser != null) {
        loginMethods =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);
        if (loginMethods.contains('password')) {
          throw AuthException(
              message:
                  'Você usou o e-mail para cadastrar no TodoLIst,caso tenha esquecido sua senha cllick no link esqueci minha senha !');
        } else {
          final googleAuth = await googleUser.authentication;
          final firebaseCredencial = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          var userCredencial =
              await _firebaseAuth.signInWithCredential(firebaseCredencial);
          return userCredencial.user;
        }
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e, s) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print(s);
      }

      if (e.code != 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                'Você se registrou no TODOLIST com os  seguinte Provedores: ${loginMethods?.join(',')} ');
      } else {
        throw AuthException(message: 'Erro ao realizar o Login!');
      }
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }

  @override
  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      user.reload();
    }
  }
}
