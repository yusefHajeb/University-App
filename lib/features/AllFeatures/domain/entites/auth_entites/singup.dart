import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SingUp extends Equatable {
  String? tId;
  String? username;
  String? password;
  String? email;
  String? token;
  String? record;
  String? name;
  String? batchId;
  String? gender;

  String? image;
  String? isOnline;
  String? status;
  String? phone;

  SingUp({
    this.tId,
    this.name,
    this.batchId,
    this.gender,
    this.image,
    this.isOnline,
    this.status,
    this.username,
    this.password,
    this.token,
    this.phone,
    this.record,
    this.email,
  });
  SingUp copyWith(
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
    return SingUp(
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

  @override
  List<Object?> get props => [
        tId,
        name,
        batchId,
        gender,
        image,
        isOnline,
        status,
        username,
        password,
        token,
        record,
        email,
        phone,
      ];
}

// class Login extends Equatable {
//   final String? email;
//   final String? record;
//   final String? token;
//   Login({required this.email, required this.record, required this.token});

//   @override
//   // TODO: implement props
//   List<Object?> get props => [email, record, token];
// }

// class LoginResponse {
//   String token;
//   String message;

//   LoginResponse({
//     required this.token,
//     required this.message,
//   });

//   factory LoginResponse.fromJson(String jsonString) {
//     final jsonData = json.decode(jsonString);
//     return LoginResponse(
//       token: jsonData['token'],
//       message: jsonData['message'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'token': token,
//       'message': message,
//     };
//   }

//   String toRawJson() => json.encode(toJson());
// }
