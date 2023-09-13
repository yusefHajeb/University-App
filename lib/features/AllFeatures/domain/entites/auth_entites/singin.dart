import 'package:equatable/equatable.dart';

class Singin extends Equatable {
  final String password;

  final String record;
  Singin({
    required this.password,
    required this.record,
  });
  @override
  List<Object?> get props => [password, record];
}
