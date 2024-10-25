import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class SignInUseCase {
  final DatabaseRepository repository;

  SignInUseCase({required this.repository});

  Future<bool> call(StudentEntity user) {
    return repository.signIn(user);
  }
}
