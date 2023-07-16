import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import 'package:university/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/repositories/schedule_repository.dart';
import 'package:university/network/check_network.dart';

import '../datasource/SchedulDatatSource/schedul_local_data_source.dart';
import '../datasource/SchedulDatatSource/shedul_remote_datasource.dart';

class SchedulRepositoryImp implements ScheduleRepository {
  final SchedulRemoteDataSource remoteSchedul;
  final SchedulLocalDataSource localSource;
  final NetworkInfo networkInfo;
  SchedulRepositoryImp({
    required this.networkInfo,
    required this.remoteSchedul,
    required this.localSource,
  });
  @override
  Future<Either<Failure, List<Schedule>>> getAllTodos() async {
    if (await networkInfo.isConnected) {
      try {
        final List<SchedulModel> remoteData =
            await remoteSchedul.getAllSchedul();
        localSource.cacheSchedul(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<SchedulModel> localData =
            await localSource.getCachedSchedul();
        return Right(localData);
      } on EmptyCasheException {
        return Left(EmptyCasheFailure());
      }
    }
  }
}
