import 'package:flutter/material.dart';
import 'package:news_app/core/consts/storage_keys.dart';
import 'package:news_app/core/extensions/extensions.dart';
import 'package:news_app/core/services/preferences_manager.dart';

class SignInController extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  String? errorMessage;
  bool isLoading = false;

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  Future<bool> signIn() async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    final savedEmail = PreferencesManager().getString(StorageKeys.userEmail);
    final savedPassword = PreferencesManager().getString(StorageKeys.userPassword);

    final email = emailController.text.trim();
    final password = passwordController.text;

    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      errorMessage = 'Please enter email and password.';
    } else if (!email.isValidEmail) {
      errorMessage = 'Please enter a valid email address.';
    } else if (savedEmail == null || savedPassword == null) {
      errorMessage = 'No account found. Please sign up first.';
    } else if (email != savedEmail || password != savedPassword) {
      errorMessage = 'Incorrect email or password.';
    }

    isLoading = false;
    notifyListeners();

    if (errorMessage != null) return false;

    await PreferencesManager().setBool(StorageKeys.isLogin, true);
    return true;
  }
}
