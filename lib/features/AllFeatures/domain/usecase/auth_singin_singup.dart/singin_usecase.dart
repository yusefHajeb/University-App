import 'package:dartz/dartz.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singin.dart';
import 'package:university/features/AllFeatures/domain/entites/auth_entites/singup.dart';
import 'package:university/features/AllFeatures/domain/repositories/auth_repositories/student_repository.dart';

import '../../../../../core/error/failure.dart';

class SingInUsecase {
  final StudentRepository repository;

  SingInUsecase({required this.repository});
  Future<Either<Failure, SingUp>> call(Singin singin) async {
    return repository.singInStuden(singin);
  }
}
