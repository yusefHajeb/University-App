import 'package:equatable/equatable.dart';

class Singin extends Equatable {
  final String? username;
  final String? password;
  final String? email;
  final String? token;
  final String? record;
  Singin({
    required this.username,
    required this.password,
    required this.token,
    required this.record,
    required this.email,
  });
  @override
  List<Object?> get props => [username, password, token, record, email];
}
