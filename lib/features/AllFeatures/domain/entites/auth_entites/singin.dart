import 'package:equatable/equatable.dart';

class Singin extends Equatable {
  final String? username;
  final String? password;
  final String? email;
  final String? token;
  final String? record;
  Singin({
    this.username,
    required this.password,
    this.token,
    required this.record,
    this.email,
  });
  @override
  List<Object?> get props => [username, password, token, record, email];
}
