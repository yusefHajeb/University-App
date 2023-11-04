import 'package:equatable/equatable.dart';

class Notificatons extends Equatable {
  final String? title;
  final String? contant;
  final String? instructor;
  final String? date;
  Notificatons({this.title, this.instructor, this.date,this.contant});

  @override
  // TODO: implement props
  List<Object?> get props => [title, contant, instructor, date];
}
