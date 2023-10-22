import '../../domain/entites/schedule.dart';

// ignore: must_be_immutable
class SchedulModel extends Schedule {
  SchedulModel({
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
  }) : super(
          tId: tId,
          status: status,
          courseName: courseName,
          days: days,
          note: note,
          instructorName: instructorName,
          time: time,
          classroom: classroom,
          batchName: batchName,
          level: level,
          dept: dept,
        );

  factory SchedulModel.formJson(Map<String, dynamic> data) {
    return SchedulModel(
      tId: data[SchedulModelKeys.tabelId]?.toString(),
      courseName: data[SchedulModelKeys.courseName]?.toString(),
      instructorName: data[SchedulModelKeys.instructorName]?.toString(),
      dept: data[SchedulModelKeys.dept]?.toString(),
      level: data[SchedulModelKeys.level]?.toString(),
      classroom: data[SchedulModelKeys.classroom]?.toString(),
      time: data[SchedulModelKeys.time]?.toString(),
      days: data[SchedulModelKeys.day]?.toString(),
      batchName: data[SchedulModelKeys.batchName]?.toString(),
      status: data[SchedulModelKeys.status]?.toString(),
      note: data[SchedulModelKeys.note]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // SchedulModelKeys.tabelId: coures,
      SchedulModelKeys.tabelId: tId,
      SchedulModelKeys.day: days,
      SchedulModelKeys.dept: dept,
      SchedulModelKeys.level: level,
      SchedulModelKeys.courseName: classroom,
      SchedulModelKeys.time: time,
      SchedulModelKeys.classroom: classroom,
      SchedulModelKeys.batchName: batchName,
      SchedulModelKeys.instructorName: instructorName,
      SchedulModelKeys.status: status,
      SchedulModelKeys.note: note,
    };
  }
}

class SchedulModelKeys {
  static const tabelId = "t_id";
  static const day = "day_id";
  static const dept = "dept_name";
  static const level = "level_name";
  static const courseName = "coures_name";
  static const time = "time_name";
  static const classroom = "classroom_name";
  static const batchName = "batch_name";
  static const instructorName = "instructor_name";
  static const status = "state_lectuer";
  static const note = "note";
}
