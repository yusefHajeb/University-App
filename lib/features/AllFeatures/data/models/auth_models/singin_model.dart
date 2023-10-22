import 'dart:convert';
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
          password: password,
          record: record,
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
  static const String username = "std_";
  static const String password = "std_";
  static const String token = "std_";
  static const String record = "std_";
  static const String email = "std_";
}
