import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';

import '../../../../core/error/failure.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, List<Schedule>>> getALLSchedule();
  Future<Either<Failure, Schedule>> getNotification();
  Future<Either<Failure, List<Schedule>>> getLetchersToday(String dateDay);
}
