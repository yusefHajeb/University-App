import 'dart:convert';

import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
import 'package:university/app/extensions.dart';

class SinginModel extends Singin {
  SinginModel(
      {String? username,
      required String password,
      String? token,
      required String record,
      String? email})
      : super(
          password: password.orEmpty(),
          record: record.orEmpty(),
        );

  factory SinginModel.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return SinginModel(
      record: jsonData['record'] ?? "",
      email: jsonData['email'] ?? "",
      username: jsonData['username'] ?? "",
      password: jsonData['password'] ?? "",
      token: jsonData['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'record': record,
    };
  }

  String toRawJson() => json.encode(toJson());
}

class LoginModelFields {
  static const String username = "username";
  static const String password = "password";
  static const String token = "token";
  static const String record = "record";
  static const String email = "email";
}
