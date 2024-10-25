import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetCreateCurrentUserUseCase {
  final DatabaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(StudentEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
