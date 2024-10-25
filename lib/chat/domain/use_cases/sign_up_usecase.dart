import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class SignUpUseCase {
  final DatabaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(StudentEntity user) {
    return repository.signUp(user);
  }
}
