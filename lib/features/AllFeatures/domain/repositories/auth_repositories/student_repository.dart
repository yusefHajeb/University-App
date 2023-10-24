import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';

import '../../../../../core/error/failure.dart';
import '../../entites/auth_entites/singin.dart';

abstract class StudentRepository {
  Future<Either<Failure, SingUp>> singInStuden(Singin singin);
  Future<Either<Failure, SingUp>> singUpStudent(SingUp singUp);
  Future<Either<Failure, Unit>> updateDataUser(SingUp singUp);
}
