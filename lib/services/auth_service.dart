import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/user.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _authenticating = false;

  final _storage = new FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  // Getters token
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {
      'email': email,
      'password': password,
    };

    var url = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);

    this.authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    authenticating = true;

    final data = {
      "name": name,
      'email': email,
      'password': password,
    };

    var url = Uri.parse('${Environment.apiUrl}/login/new');
    final resp = await http.post(url,
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);

    this.authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _logoutToken() async {
    await _storage.delete(key: 'token');
  }
}
