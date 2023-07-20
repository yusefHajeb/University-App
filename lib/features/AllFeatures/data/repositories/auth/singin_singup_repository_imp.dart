import 'package:university/core/error/execptions.dart';
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
  Future<Either<Failure, Unit>> singInStuden(Singin singin) async {
    final singInModel = SinginModel(
        username: singin.username!,
        password: singin.password!,
        token: singin.token!,
        record: singin.record!,
        email: singin.email!);

    return await _getMessage(() => remoteData.singinStudent(singInModel));
  }

  @override
  Future<Either<Failure, Unit>> singUpStudent(SingUp singUp) async {
    if (await networkInfo.isConnected) {
      final SingUpModel singUpModel = SingUpModel(
        password: singUp.password!,
        email: singUp.email!,
        record: singUp.record!,
        token: singUp.record!,
        username: singUp.username!,
      );
      // final SingUpModel date = await remoteData.singUpStudent(singUp);
      //     await remoteData.getScheduleNotification();
      // localSource.cacheSchedulNotifiction(remoteData);
      return await _getMessage(() => remoteData.singUpStudent(singUpModel));
    } else {
      return Left(OffLineFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      SingInOrSingUpStudent singinOrSingUpStudent) async {
    if (await networkInfo.isConnected) {
      try {
        singinOrSingUpStudent;
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}
