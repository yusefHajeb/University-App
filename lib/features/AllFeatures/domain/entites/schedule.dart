import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String subject;
  final String? type;
  final String? teacherName;
  final DateTime? time;
  bool isPassed = false;
  bool isHappening = false;
  bool isCansel = false;
  Schedule(
      {required this.subject,
      required this.type,
      required this.teacherName,
      required this.time});

  @override
  List<Object?> get props =>
      [subject, type, teacherName, time, isPassed, isHappening, isCansel];
}
