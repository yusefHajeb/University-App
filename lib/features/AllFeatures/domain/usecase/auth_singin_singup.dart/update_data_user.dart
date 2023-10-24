import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../entites/auth_entites/singup.dart';
import '../../repositories/auth_repositories/student_repository.dart';

class UpdateDataUserUsecase {
  final StudentRepository repository;

  UpdateDataUserUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(SingUp singUp) async {
    return await repository.updateDataUser(singUp);
  }
}
