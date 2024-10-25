import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetCurrentUIDUseCase {
  final DatabaseRepository repository;

  GetCurrentUIDUseCase({required this.repository});
  Future<StudentEntity> call(StudentEntity user) async {
    return await repository.getCurrentUId(user);
  }
}
