import 'package:beautysalon/components/databasehelper';
import 'package:beautysalon/components/user.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<bool> signIn(String email, String password) async {
    final user = await _dbHelper.getUserByEmail(email);
    if (user != null && user.password == password) { 
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await _dbHelper.insertUser(User(email: email, password: password));
      return true;
    } catch (e) {
      return false;
    }
  }
}