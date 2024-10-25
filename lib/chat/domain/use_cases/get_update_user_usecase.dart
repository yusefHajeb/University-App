import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetUpdateUserUseCase {
  final DatabaseRepository repository;

  GetUpdateUserUseCase({required this.repository});
  Future<void> call(StudentEntity user) {
    return repository.getUpdateUser(user);
  }
}
