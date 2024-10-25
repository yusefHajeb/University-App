import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetAllUsersUseCase {
  final DatabaseRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<StudentEntity>> call(int batch_id) {
    return repository.getAllUsers(batch_id);
  }
}
