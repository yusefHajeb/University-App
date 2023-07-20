// import 'dart:convert';

// import 'package:university/features/AllFeatures/domain/entites/auth_entites/login.dart';

import 'dart:convert';

import 'package:university/features/AllFeatures/domain/entites/auth_entites/login.dart';

class SingUpModel extends SingUp {
  SingUpModel(
      {required String email,
      required String record,
      required String token,
      required String username,
      required String password})
      : super(
            email: email,
            record: record,
            token: token,
            username: username,
            password: password);

  factory SingUpModel.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return SingUpModel(
        email: jsonData['email'],
        record: jsonData['record'],
        token: jsonData['token'],
        password: jsonData['password'],
        username: jsonData['username']);
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'record': record,
      'token': token,
    };
  }

  String toRawJson() => json.encode(toJson());
}
