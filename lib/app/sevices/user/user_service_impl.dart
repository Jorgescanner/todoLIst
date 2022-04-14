// ignore_for_file: empty_constructor_bodies

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todo_list_provider/app/repositories/user/user_repository.dart';
import './user_service.dart';

class UserServicempl implements UserService {
  final UserRepository _userRepository;

  UserServicempl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);

  @override
  Future<void> forgotPassword(String email) =>
      _userRepository.forgotPassword(email);

  @override
  Future<User?> googleLogin() => _userRepository.googleLogin();

  @override
  Future<void> logout() => _userRepository.logout();

  @override
  Future<void> updateDisplayName(String name) =>
      _userRepository.updateDisplayName(name);
}
