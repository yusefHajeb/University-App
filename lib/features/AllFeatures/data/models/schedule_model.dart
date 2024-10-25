import '../../domain/entites/schedule.dart';

// ignore: must_be_immutable
class SchedulModel extends Schedule {
  SchedulModel({
    String? date,
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
          imageInstractor: imageInstractor,
          date: date,
        );

  factory SchedulModel.formJson(Map<String, dynamic> data) {
    return SchedulModel(
      tId: data[SchedulModelKeys.tabelId]?.toString(),
      courseName: data[SchedulModelKeys.courseName]?.toString(),
      instructorName: data[SchedulModelKeys.instructorName]?.toString() ?? "",
      // dept: data[SchedulModelKeys.dept]?.toString(),
      // level: data[SchedulModelKeys.level]?.toString(),
      classroom: data[SchedulModelKeys.classroom]?.toString() ?? "",
      time: data[SchedulModelKeys.time]?.toString() ?? "",
      days: data[SchedulModelKeys.day]?.toString() ?? "",
      // batchName: data[SchedulModelKeys.batchName]?.toString(),
      status: data[SchedulModelKeys.status]?.toString(),
      note: data[SchedulModelKeys.note]?.toString() ?? "",
      imageInstractor: data[SchedulModelKeys.imageInstractor]?.toString() ?? "",
      date: data[SchedulModelKeys.date]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // SchedulModelKeys.tabelId: coures,
      SchedulModelKeys.tabelId: tId,
      SchedulModelKeys.day: days,
      // SchedulModelKeys.dept: dept,
      // SchedulModelKeys.level: level,
      SchedulModelKeys.courseName: classroom,
      SchedulModelKeys.time: time,
      SchedulModelKeys.classroom: classroom,
      // SchedulModelKeys.batchName: batchName,
      SchedulModelKeys.instructorName: instructorName,
      SchedulModelKeys.status: status,
      SchedulModelKeys.note: note,
      SchedulModelKeys.imageInstractor: imageInstractor,
      SchedulModelKeys.date: date,
    };
  }
}

class SchedulModelKeys {
  static const tabelId = "t_id";
  static const day = "day_name";
  // static const dept = "dept_name";

  static const courseName = "coures_name";
  static const time = "time_name";
  static const classroom = "classroom_name";
  static const instructorName = "instructor_name";
  static const status = "state_lectuer";
  static const note = "note_lectuer";
  static const String date = "";
  static const String imageInstractor = "instructor_img";
  static const String dateLectue = "date_lectuer";
}

  //  t_id: 64,
  //   day_id: 5,
  //   dept_name: 'تقنية المعلومات',
  //   level_name: 'المستوى الأول',
  //   coures_name: 'فواعد بيانات 2',
  //   time_name: 'الثانية',
  //   classroom_name: 'الرازي',
  //   instructor_name: 'منير السروري',
  //   day_name: 'الخميس'
