import '../../domain/entites/schedule.dart';

// ignore: must_be_immutable
class SchedulModel extends Schedule {
  SchedulModel({
    String? coures,
    String? instructor,
    String? dept,
    String? level,
    String? classroom,
    String? time,
    String? days,
    String? batch,
  }) : super(
          coures: coures,
          days: days,
          instructor: instructor,
          time: time,
          classroom: classroom,
          batch: batch,
          level: level,
          dept: dept,
        );

  factory SchedulModel.formJson(Map<String, dynamic> data) {
    return SchedulModel(
        coures: data['coures'] as String?,
        instructor: data['instructor'] as String?,
        dept: data['dept'] as String?,
        level: data['level'] as String?,
        classroom: data['classroom'] as String?,
        time: data['time'] as String?,
        days: data['days'] as String?,
        batch: data['batch'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {
      'coures': coures,
      'instructor': instructor,
      'dept': dept,
      'level': level,
      'classroom': classroom,
      'time': time,
      'days': days,
      'batch': batch,
    };
  }
}
