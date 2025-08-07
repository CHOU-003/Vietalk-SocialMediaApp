// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/repo/auth_repo.dart';

class Authprovider extends ChangeNotifier {
  final _repo = Authrepo();

  //for register
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> registerUser(username, email, password) async {
    _isLoading = true;
    notifyListeners();
    final respone = await _repo.register(username, email, password);
    if (respone.statusCode == 201) {
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  //for login
  Future<bool> loginUser(email, password) async {
    _isLoading = true;
    notifyListeners();
    final respone = await _repo.login(email, password);
    if (respone.statusCode == 200) {
      final result = json.decode(respone.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['token']);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  //Logout Screen
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
