import 'dart:convert';

import 'package:university/features/AllFeatures/domain/entites/auth_entites/login.dart';

class LoginModel extends Login {
  LoginModel(
      {required super.email, required super.record, required super.token});

  factory LoginModel.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return LoginModel(
        email: jsonData['email'],
        record: jsonData['record'],
        token: jsonData['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'record': record,
      'token': token,
    };
  }

  String toRawJson() => json.encode(toJson());
}
