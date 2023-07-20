import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/data/models/auth_models/singin_model.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';

import '../../../../../core/error/failure.dart';
import '../../entites/auth_entites/singin.dart';

abstract class StudentRepository {
  Future<Either<Failure, Unit>> singInStuden(Singin singin);
  Future<Either<Failure, Unit>> singUpStudent(SingUp singUp);
}
