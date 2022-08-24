import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:paap/environment/environment.dart';
import 'package:paap/helpers/error_helper.dart';
import 'package:paap/utils/secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = Environment.url;
  Map<String, dynamic> errorMap = {};

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('$_baseUrl/api/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(authData),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (resp.statusCode == 200) {
      if (decodedResp.containsKey('token')) {
        SecureStorage.storage.write(key: 'token', value: decodedResp['token']);
      }
      return decodedResp;
    } else {
      return ErrorHelper.manageError(resp);
    }
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('$_baseUrl/api/auth/sign-up'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(authData),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (resp.statusCode == 200) return decodedResp;

    return ErrorHelper.manageError(resp);
  }

  Future<Map<String, dynamic>> forgotPwd(String email) async {
    final resp = await http.post(
      Uri.parse('$_baseUrl/api/auth/send-mail-restore/$email'),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (resp.statusCode == 200) return decodedResp;

    return ErrorHelper.manageError(resp);
  }

  Future logout() async {
    await SecureStorage.storage.delete(key: 'token');
    return;
  }
}
