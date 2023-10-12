// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Student extends Equatable {
  String? name;
  String? username;
  String? password;
  String? record;
  String? patch_id;
  Student(
      {this.name, this.username, this.password, this.patch_id, this.record});
  @override
  List<Object?> get props => [name, username, password, record, patch_id];
}
