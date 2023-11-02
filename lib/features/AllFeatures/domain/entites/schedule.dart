import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Schedule extends Equatable {
  String? date;
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
  String? imageInstractor;
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
    this.imageInstractor,
    this.date,
  });

  Schedule copyWith({
    String? tId,
    String? courseName,
    String? instructorName,
    String? dept,
    String? level,
    String? classroom,
    String? time,
    String? days,
    String? batchName,
    String? status,
    String? note,
    String? imageInstractor,
    String? date,
  }) {
    return Schedule(
      batchName: batchName ?? this.batchName,
      classroom: classroom ?? this.classroom,
      courseName: courseName ?? this.courseName,
      days: days ?? this.days,
      dept: dept ?? this.dept,
      instructorName: instructorName ?? this.instructorName,
      note: note ?? this.note,
      status: status ?? this.status,
      tId: tId ?? this.tId,
      time: time ?? this.time,
      imageInstractor: imageInstractor ?? this.imageInstractor,
      date: date ?? this.date,
    );
  }

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
        imageInstractor,
        date,
      ];
}
