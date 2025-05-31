import 'package:flutter/cupertino.dart';

import '../../../core/consts/storage_keys.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/services/preferences_manager.dart';

class SignUpController with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? errorMessage;
  bool isLoading = false;


  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  Future<bool> signUp() async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();


    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    await Future.delayed(const Duration(milliseconds: 500));

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {

        errorMessage = 'Please fill in all fields.';
        isLoading = false;

     notifyListeners();
    }
    if (!email.isValidEmail) {
        errorMessage = 'Please enter a valid email address.';
        isLoading = false;
    notifyListeners();
    }
    if (password.length < 6) {
      errorMessage = 'Password must be at least 6 characters.';
        isLoading = false;
      notifyListeners();
    }
    if (password != confirmPassword) {
        errorMessage = 'Passwords do not match.';
        isLoading = false;
     notifyListeners();
    }

    final savedEmail = PreferencesManager().getString(StorageKeys.userEmail);
    if (savedEmail != null && savedEmail == email) {
        errorMessage = 'An account with this email already exists.';
        isLoading = false;
     notifyListeners();
    }

    await  PreferencesManager().setString(StorageKeys.userEmail, email);
    await  PreferencesManager().setString(StorageKeys.userPassword, password);
    await  PreferencesManager().setBool(StorageKeys.isLogin, true);
    notifyListeners();
    return true;
  }


}