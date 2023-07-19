import 'dart:convert';

import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String? email;
  final String? record;
  final String? token;
  Login({required this.email, required this.record, required this.token});

  @override
  // TODO: implement props
  List<Object?> get props => [email, record, token];
}


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