import 'package:dartz/dartz.dart';
import 'package:university/core/error/failure.dart';
import 'package:university/features/AllFeatures/domain/repositories/schedule_repository.dart';

import '../../entites/schedule.dart';

class GetNotificationScheduleUsecase {
  final ScheduleRepository scheduleRepository;

  GetNotificationScheduleUsecase({required this.scheduleRepository});

  Future<Either<Failure, Schedule>> call() async {
    return await scheduleRepository.getNotification();
  }
}
