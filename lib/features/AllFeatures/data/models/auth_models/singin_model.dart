import 'dart:convert';

import 'package:university/features/AllFeatures/domain/entites/auth_entites/login.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';

class SinginModel extends Singin {
  SinginModel(
      {required String username,
      required String password,
      required String token,
      required String record,
      required String email})
      : super(
            password: password,
            username: username,
            token: token,
            record: record,
            email: email);

  factory SinginModel.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString);
    return SinginModel(
      record: jsonData['record'],
      email: jsonData['email'],
      username: jsonData['username'],
      password: jsonData['password'],
      token: jsonData['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'token': token,
      'record': record,
      'email': email
    };
  }

  String toRawJson() => json.encode(toJson());
}
