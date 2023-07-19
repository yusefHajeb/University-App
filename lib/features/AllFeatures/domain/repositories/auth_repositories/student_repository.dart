import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entites/auth_entites/singin.dart';

abstract class StudentRepository {
  Future<Either<Failure, Singin>> singInStuden(Singin singin);
  Future<Either<Failure, Singin>> singUpStdent();
}
