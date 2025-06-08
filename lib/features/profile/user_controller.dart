import 'package:flutter/material.dart';
import '../../core/consts/storage_keys.dart';
import '../../core/services/preferences_manager.dart';

class UserController extends ChangeNotifier {
  String? username;
  String? email;
  String? pass;
  String? userImagePath;

  Future<void> loadUserData() async {
    username = PreferencesManager().getString(StorageKeys.username);
    email = PreferencesManager().getString(StorageKeys.userEmail);
    pass = PreferencesManager().getString(StorageKeys.userPassword);
    userImagePath = PreferencesManager().getString(StorageKeys.userImage);
    notifyListeners();
  }

  Future<void> updateUserData({
    required String username,
    required String email,
    required String pass,
  }) async {
    await PreferencesManager().setString(StorageKeys.username, username);
    await PreferencesManager().setString(StorageKeys.userEmail, email);
    await PreferencesManager().setString(StorageKeys.userPassword, pass);
    this.username = username;
    this.email = email;
    this.pass = pass;
    notifyListeners();
  }

  Future<void> updateUserImage(String imagePath) async {
    await PreferencesManager().setString(StorageKeys.userImage, imagePath);
    userImagePath = imagePath;
    notifyListeners();
  }

  Future<void> clearUserData() async {
    await PreferencesManager().remove(StorageKeys.username);
    await PreferencesManager().remove(StorageKeys.userEmail);
    await PreferencesManager().remove(StorageKeys.userPassword);
    await PreferencesManager().remove(StorageKeys.userImage);
    username = null;
    email = null;
    pass = null;
    userImagePath = null;
    notifyListeners();
  }
}
