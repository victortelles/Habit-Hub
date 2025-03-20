import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool _isDarkMode = false;
  Map<String, bool> _habitStatus = {
    'Pasear al perro': false,
    'Regar las plantas': false,
    'Tender la cama': false,
    'Ir al gym': false,
    'Lectura diaria': false,
  };

  bool get isDarkMode => _isDarkMode;
  Map<String, bool> get habitStatus => _habitStatus;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateHabit(String habit, bool status) {
    _habitStatus[habit] = status;
    notifyListeners();
  }
}

