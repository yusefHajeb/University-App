import 'dart:convert';
import 'package:university/chat/data/remote/models/student_model.dart';
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
import '../../../../../chat/domain/entities/student_entity.dart';
import '../../../../../core/constant/varibal.dart';
import '../../../domain/repositories/auth_repositories/student_repository.dart';
import '../../datasource/AuthDatatSource/auth_remote_database.dart';

typedef SingInOrSingUpStudent = Future<Unit> Function();
StudentEntity? dataStudentEntity;

class StudentRepositoryImp implements StudentRepository {
  final SingInOrSingUpRemoteDataSource remoteData;
  // final SharedPreferences pref;
  // final ScheduleLocalDataSource localSource;
  final NetworkInfo networkInfo;
  StudentRepositoryImp({
    required this.networkInfo,
    required this.remoteData,
  });
  @override
  Future<Either<Failure, SingUp>> singInStuden(Singin singin) async {
    // if (await networkInfo.isConnected) {
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
          .setString(Constants.userData, json.encode(remote.toJson()));
      Global.storgeServece.setBool(Constants.STORGE_USER_LOGED_FIRST, true);
      // final data = jsonDecode(
      //     Global.storgeServece.getStringData(Constants.userData).toString());
      // final StudentEntity d = StudentModel.fromJson(data);
      dataStudentEntity = new StudentEntity(
          std_image: remote.image ?? "",
          std_name: remote.name ?? "",
          batch_id: int.parse(remote.batchId ?? "12"),
          t_id: int.parse(remote.tId ?? "12"),
          std_email: remote.email.toString());
      print('تم تحميل البيانات بنجاح');

      return Right(remote);
    } on ServerException {
      return Left(SingInFailure());
    }
    // } else {
    //   return Left(OffLineFailure());
    // }
  }

  @override
  Future<Either<Failure, SingUp>> singUpStudent(SingUp singUp) async {
    if (await networkInfo.isConnected) {
      final SingUpModel singUpModel = SingUpModel(
        phone: singUp.phone,
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

  @override
  Future<Either<Failure, Unit>> updateDataUser(SingUp singUp) async {
    SingUpModel user = SingUpModel(
      email: singUp.email,
      image: singUp.image,
      name: singUp.name,
      password: singUp.password,
      phone: singUp.phone,
    );
    if (await networkInfo.isConnected) {
      try {
        print("user in implement");
        print(user);
        Unit remote = await remoteData.updateDataUser(user);
        return Right(remote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }

    // return await _getMessage(() => remoteData.updateDataUser(user));
    // return  Left(ServerFailure());
  }

  Future<Either<Failure, Unit>> _getMessage(
      SingInOrSingUpStudent singinOrSingUpStudent) async {
    if (await networkInfo.isConnected) {
      try {
        singinOrSingUpStudent;
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
