import 'dart:convert';

import 'package:university/core/error/execptions.dart';
import 'package:university/core/value/global.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singin_model.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singup_model.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
// import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';
import 'package:university/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:university/core/network/check_network.dart';
import '../../../domain/repositories/auth_repositories/student_repository.dart';
import '../../datasource/AuthDatatSource/auth_remote_database.dart';

typedef SingInOrSingUpStudent = Future<Unit> Function();

class StudentRepositoryImp implements StudentRepository {
  final SingInOrSingUpRemoteDataSource remoteData;
  // final ScheduleLocalDataSource localSource;
  final NetworkInfo networkInfo;
  StudentRepositoryImp({
    required this.networkInfo,
    required this.remoteData,
  });
  @override
  Future<Either<Failure, SingUp>> singInStuden(Singin singin) async {
    if (await networkInfo.isConnected) {
      try {
        final singInModel = SinginModel(
          password: singin.password,
          record: singin.record,
        );
        SingUpModel? remote = await remoteData.singinStudent(singInModel);

        print("===========================$singInModel  repository");
        // return await _getMessage(() => remoteData.singinStudent(singInModel));
        if (remote == null) {
          return Left(SingInFailure());
        }
        print("remote.toJson()");
        print(remote.toJson());
        Global.storgeServece
            .setString("STUDEN_DATA", json.encode(remote.toJson()));
        return Right(remote);
      } on ServerException {
        return Left(SingInFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, SingUp>> singUpStudent(SingUp singUp) async {
    if (await networkInfo.isConnected) {
      final SingUpModel singUpModel = SingUpModel(
        password: singUp.password!,
        email: singUp.email!,
        record: singUp.record!,
        username: singUp.username!,
      );
      // final  date = await remoteData.singUpStudent(singUpModel);
      //     await remoteData.getScheduleNotification();
      // localSource.cacheSchedulNotifiction(remoteData);
      // return await _getMessage(() => remoteData.singUpStudent(singUpModel));
      return Right(singUpModel);
    } else {
      return Left(OffLineFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      SingInOrSingUpStudent singinOrSingUpStudent) async {
    if (await networkInfo.isConnected) {
      try {
        singinOrSingUpStudent;
        print(
            '=============================== success in repository and remote');
        return const Right(unit);
      } on ServerException {
        print('=============================== Error in repo and remote');
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
