import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entites/schedule.dart';
import '../../repositories/schedule_repository.dart';

class GetLetchersUsecase {
  final ScheduleRepository rerpository;

  GetLetchersUsecase({required this.rerpository});

  Future<Either<Failure, List<Schedule>>> call(String dateDay) async {
    return await rerpository.getLetchersToday(dateDay);
  }
}
