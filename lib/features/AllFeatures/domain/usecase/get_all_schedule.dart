import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import 'package:university/features/AllFeatures/domain/repositories/schedule_repository.dart';

import '../../../../core/error/failure.dart';

class GetAllScheduleUsecase {
  final ScheduleRepository rerpository;

  GetAllScheduleUsecase({required this.rerpository});

  Future<Either<Failure, List<Schedule>>> call() async {
    return await rerpository.getAllTodos();
  }
}
