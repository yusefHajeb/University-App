// import 'dart:convert';

// import 'package:university/features/AllFeatures/domain/entites/auth_entites/login.dart';

import 'dart:convert';

import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';

// ignore: must_be_immutable
class SingUpModel extends SingUp {
  SingUpModel(
      {String? tId,
      String? image,
      String? name,
      String? gender,
      String? batchId,
      String? phone,
      String? isOnline,
      String? status,
      String? email,
      String? record,
      String? username,
      String? password})
      : super(
          tId: tId,
          image: image,
          name: name,
          gender: gender,
          batchId: batchId,
          isOnline: isOnline,
          phone: phone,
          status: status,
          email: email,
          record: record,
          username: username,
          password: password,
        );

  SingUpModel copyWith(
      {String? tId,
      String? image,
      String? name,
      String? gender,
      String? batchId,
      String? phone,
      String? isOnline,
      String? status,
      String? email,
      String? record,
      String? username,
      String? password}) {
    return SingUpModel(
      tId: tId ?? this.tId,
      image: image ?? this.image,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      batchId: batchId ?? this.batchId,
      isOnline: isOnline ?? this.isOnline,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      email: email ?? this.email,
      record: record ?? this.record,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  factory SingUpModel.fromMap(Map<String, dynamic> jsonData) {
    return SingUpModel(
        email: jsonData[SingUpModelKeys.email]?.toString() ?? "",
        record: jsonData[SingUpModelKeys.record]?.toString() ?? "",
        image: jsonData[SingUpModelKeys.image]?.toString() ?? "",
        password: jsonData[SingUpModelKeys.password]?.toString() ?? "",
        name: jsonData[SingUpModelKeys.name]?.toString() ?? "",
        batchId: jsonData[SingUpModelKeys.batchId]?.toString() ?? "",
        tId: jsonData[SingUpModelKeys.tid]?.toString() ?? "",
        isOnline: jsonData[SingUpModelKeys.isOnline]?.toString() ?? "",
        gender: jsonData[SingUpModelKeys.gender]?.toString() ?? "",
        phone: jsonData[SingUpModelKeys.phone]?.toString() ?? "",
        status: jsonData[SingUpModelKeys.status]?.toString() ?? "");
  }

  factory SingUpModel.fromJson(String data) {
    final jsonData = json.decode(data);
    return SingUpModel(
        email: jsonData[SingUpModelKeys.email]?.toString() ?? "",
        record: jsonData[SingUpModelKeys.record]?.toString() ?? "",
        image: jsonData[SingUpModelKeys.image]?.toString() ?? "",
        password: jsonData[SingUpModelKeys.password]?.toString() ?? "",
        name: jsonData[SingUpModelKeys.name]?.toString() ?? "",
        batchId: jsonData[SingUpModelKeys.batchId]?.toString() ?? "",
        tId: jsonData[SingUpModelKeys.tid]?.toString() ?? "",
        isOnline: jsonData[SingUpModelKeys.isOnline]?.toString() ?? "",
        gender: jsonData[SingUpModelKeys.gender]?.toString() ?? "",
        phone: jsonData[SingUpModelKeys.phone]?.toString() ?? "",
        status: jsonData[SingUpModelKeys.status]?.toString() ?? "");
  }

  factory SingUpModel.formJson(Map<String, dynamic> jsonData) {
    return SingUpModel(
        email: jsonData[SingUpModelKeys.email]?.toString() ?? "",
        record: jsonData[SingUpModelKeys.record]?.toString() ?? "",
        image: jsonData[SingUpModelKeys.image]?.toString() ?? "",
        password: jsonData[SingUpModelKeys.password]?.toString() ?? "",
        name: jsonData[SingUpModelKeys.name]?.toString() ?? "",
        batchId: jsonData[SingUpModelKeys.batchId]?.toString() ?? "",
        tId: jsonData[SingUpModelKeys.tid]?.toString() ?? "",
        isOnline: jsonData[SingUpModelKeys.isOnline]?.toString() ?? "",
        gender: jsonData[SingUpModelKeys.gender]?.toString() ?? "",
        phone: jsonData[SingUpModelKeys.phone]?.toString() ?? "",
        status: jsonData[SingUpModelKeys.status]?.toString() ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      SingUpModelKeys.tid: tId,
      SingUpModelKeys.batchId: batchId,
      SingUpModelKeys.name: name,
      SingUpModelKeys.password: password,
      SingUpModelKeys.date: token,
      SingUpModelKeys.email: email,
      SingUpModelKeys.status: status,
      SingUpModelKeys.gender: gender,
      SingUpModelKeys.isOnline: isOnline,
      SingUpModelKeys.phone: phone,
      SingUpModelKeys.record: record,
      SingUpModelKeys.image: image,
    };
  }

  String toRawJson() => json.encode(toJson());
}

class SingUpModelKeys {
  static const String tid = "t_id";
  static const String name = 'std_name';
  static const String password = "std_password";
  static const String record = "std_record";
  static const String phone = "std_phone";
  static const String batchId = "batch_id";
  static const String gender = "std_gander";
  static const String image = "std_image";
  static const String date = "std_date_school";
  static const String isOnline = "isOnline";
  static const String status = "status";
  static const String email = "std_email";
}

// t_id: 46,
//     std_name: '5ryerye',
//     std_password: 'tret',
//     std_record: 6536,
//     std_phone: 4345345,
//     batch_id: 13,
//     std_gander: 0,
//     std_image: '',
//     std_date_school: 2023-10-12T00:28:17.000Z,
//     isOnline: 1,
//     status: '',
//     std_email: ''