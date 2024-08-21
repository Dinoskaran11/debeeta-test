import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

class AuthService {
  final String baseUrl = "https://festive-clarke.93-51-37-244.plesk.page/api/v1";

  Future<bool> register(String name, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'role': role,
      },
    );
    return _handleAuthResponse(response);
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );
    return _handleAuthResponse(response);
  }

  Future<void> logout() async {
    final tokenBox = Hive.box('auth');
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer ${tokenBox.get('token')}',
      },
    );
    if (response.statusCode == 200) {
      tokenBox.delete('token');
      tokenBox.delete('name');
      tokenBox.delete('email');
      tokenBox.delete('role');
    }
  }

  Future<bool> _handleAuthResponse(http.Response response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);

      final userData = responseData['user'];
      final token = responseData['token'];
      final name = userData['name'];
      final email = userData['email'];
      final role = userData['role'];

      final tokenBox = await Hive.openBox('auth');
      
      tokenBox.put('token', token);
      tokenBox.put('name', name);
      tokenBox.put('email', email);
      tokenBox.put('role', role);
      return true;
    }
    return false;
  }

  String? getToken() {
    final tokenBox = Hive.box('auth');
    return tokenBox.get('token');
  }

  String? getName() {
    final tokenBox = Hive.box('auth');
    return tokenBox.get('name');
  }

  String? getEmail() {
    final tokenBox = Hive.box('auth');
    return tokenBox.get('email');
  }

  String? getRole() {
    final tokenBox = Hive.box('auth');
    return tokenBox.get('role');
  }
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _token;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    _isAuthenticated = await _authService.login(email, password);
    _token = _authService.getToken();
    notifyListeners();
    return _isAuthenticated; 
  }

  Future<bool> register(String name, String email, String password, String role) async {
    _isAuthenticated = await _authService.register(name, email, password, role);
    _token = _authService.getToken();
    notifyListeners();
    return _isAuthenticated;
  }

  void logout() {
    _authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  String? get token => _token;
}
