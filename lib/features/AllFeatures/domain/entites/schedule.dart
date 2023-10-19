import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Schedule extends Equatable {
  String? tId;
  String? courseName;
  String? instructorName;
  String? dept;
  String? level;
  String? classroom;
  String? time;
  String? days;
  String? batchName;
  String? status;
  String? note;

  Schedule({
    this.tId,
    this.courseName,
    this.instructorName,
    this.dept,
    this.level,
    this.classroom,
    this.time,
    this.days,
    this.batchName,
    this.status,
    this.note,
  });

  @override
  List<Object?> get props => [
        tId,
        courseName,
        instructorName,
        dept,
        level,
        classroom,
        time,
        days,
        batchName,
        status,
        note,
      ];
}
