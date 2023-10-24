import 'package:equatable/equatable.dart';

class Users extends Equatable {
  String? name;
  String? username;
  String? email;
  String? record;
  String? phone;

  @override
  List<Object?> get props => [name, username, email, phone, record];
}
