import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  String? coures;
  String? instructor;
  String? dept;
  String? level;
  String? classroom;
  String? time;
  String? days;
  String? batch;
  Schedule({
    this.coures,
    this.instructor,
    this.dept,
    this.level,
    this.classroom,
    this.time,
    this.days,
    this.batch,
  });

  @override
  List<Object?> get props => [
        coures,
        instructor,
        dept,
        level,
        classroom,
        time,
        days,
        batch,
      ];
}
