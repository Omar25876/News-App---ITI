import 'package:flutter/material.dart';

class AppController with ChangeNotifier {
  String _selectedLanguage = 'English';
  String _selectedLanguageCode = 'en';
  String _selectedCountry = 'Egypt';
  String _selectedCountryCode = '+20';

  String get selectedLanguage => _selectedLanguage;
  String get selectedLanguageCode => _selectedLanguageCode;

  String get selectedCountry => _selectedCountry;
  String get selectedCountryCode => _selectedCountryCode;

  void setLanguage(String name, String code) {
    _selectedLanguage = name;
    _selectedLanguageCode = code;
    notifyListeners();
  }

  void setCountry(String name, String code) {
    _selectedCountry = name;
    _selectedCountryCode = code;
    notifyListeners();
  }
}
