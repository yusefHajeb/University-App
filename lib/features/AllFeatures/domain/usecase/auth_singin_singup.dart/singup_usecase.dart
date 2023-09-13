import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/repositories/auth_repositories/student_repository.dart';

import '../../../../../core/error/failure.dart';
import '../../entites/auth_entites/singup.dart';

class SingUpUsecase {
  final StudentRepository repository;

  SingUpUsecase({required this.repository});
  Future<Either<Failure, SingUp>> call(SingUp singUp) async {
    return await repository.singUpStudent(singUp);
  }
}
