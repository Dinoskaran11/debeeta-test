import 'package:flutter/material.dart';

class RoleProvider extends ChangeNotifier {
  String _role = '';

  String get role => _role;

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  bool get isInstructor => _role == 'instructor';
  bool get isStudent => _role == 'student';
}
