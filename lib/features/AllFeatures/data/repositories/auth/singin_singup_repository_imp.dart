import 'package:university/core/error/execptions.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singin_model.dart';
import 'package:university/features/AllFeatures/data/models/schedule_model.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
import 'package:university/features/AllFeatures/domain/entites/schedule.dart';
import 'package:university/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/repositories/schedule_repository.dart';
import 'package:university/core/network/check_network.dart';

import '../../../domain/repositories/auth_repositories/student_repository.dart';
import '../../datasource/AuthDatatSource/auth_remote_database.dart';

class StudentRepositoryImp implements StudentRepository {
  final SingInOrSingUpRemoteDataSource remoteData;
  // final ScheduleLocalDataSource localSource;
  final NetworkInfo networkInfo;
  StudentRepositoryImp({
    required this.networkInfo,
    required this.remoteData,
  });
  @override
  Future<Either<Failure, Singin>> singInStuden(Singin singin) async {
    if (await networkInfo.isConnected) {
      try {
        final SinginModel remoteData2 = await remoteData.singinStudent(singin);

        return Right(remoteData2);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(EmptyCasheFailure());
    }
  }

  @override
  Future<Either<Failure, Singin>> singUpStdent() async {
    // if (await networkInfo.isConnected) {
    //   try {
    //     final SinginModel remoteData =
    //         await remoteData.getScheduleNotification();
    //     localSource.cacheSchedulNotifiction(remoteData);
    //     return Right(remoteData);
    //   } on ServerException {
    //     return Left(ServerFailure());
    //   }
    // } else {
    //   return Left(EmptyCasheFailure());
    // }
    return Left(EmptyCasheFailure());
    // } else {
    //   try {

    //   } on EmptyCasheException {
    //     return Left(EmptyCasheFailure());
    //   }
    // }
  }
}
