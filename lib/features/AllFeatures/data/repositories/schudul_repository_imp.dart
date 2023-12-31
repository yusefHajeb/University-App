import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import 'package:university/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/repositories/schedule_repository.dart';
import 'package:university/core/network/check_network.dart';
import 'package:university/main.dart';
import '../datasource/ScheduleDataSource/schedul_local_data_source.dart';
import '../datasource/ScheduleDataSource/shedul_remote_datasource.dart';

class SchedulRepositoryImp implements ScheduleRepository {
  final SchedulRemoteDataSource remoteSchedul;
  final ScheduleLocalDataSource localSource;
  final NetworkInfo networkInfo;
  SchedulRepositoryImp({
    required this.networkInfo,
    required this.remoteSchedul,
    required this.localSource,
  });
  @override
  Future<Either<Failure, List<Schedule>>> getALLSchedule() async {
    if (await socket.connected) {
      print("conacted with socket");
      try {
        final List<SchedulModel> remoteData =
            await remoteSchedul.getAllSchedul();
        print("$remoteData ============ Data");
        localSource.cacheSchedul(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        print("not socet connections");
        List<SchedulModel> localData = await localSource.getCachedSchedul();
        return Right(localData);
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Schedule>> getNotification() async {
    if (await networkInfo.isConnected) {
      try {
        final SchedulModel remoteData =
            await remoteSchedul.getScheduleNotification();
        print('=============================== schedul  in repository ');
        localSource.cacheSchedulNotifiction(remoteData);
        return Right(remoteData);
      } on ServerException {
        print('===============================ERROR schedul  in repository ');
        return Left(ServerFailure());
      }
    } else {
      return Left(EmptyCasheFailure());
    }
    // } else {
    //   try {

    //   } on EmptyCasheException {
    //     return Left(EmptyCasheFailure());
    //   }
    // }
  }

  @override
  Future<Either<Failure, List<Schedule>>> getLetchersToday(
      String dateDay) async {
    if (await socket.connected) {
      try {
        final List<SchedulModel> remoteData =
            await remoteSchedul.getLetchersToday(dateDay);
        print("$remoteData ============ Data");
        localSource.cacheSchedul(remoteData);
        localSource.cachedLetctersToday(remoteData);

        return Right(remoteData);
      } on ServerException {
        // List<SchedulModel> localData = await localSource.getCachedSchedul();
        return Left(ServerFailure());
        // return Left(EmptyCasheFailure());
      }
    } else {
      try {
        List<SchedulModel> localData = await localSource
            .getCachedLetchers("${DateTime.now().month} / $dateDay");
        return Right(localData);
      } on NotFountLetchersFailure {
        return Left(NotFountLetchersFailure());
      }
    }
  }
}
