import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class UpdateGroupUseCase {
  final DatabaseRepository repository;

  UpdateGroupUseCase({required this.repository});
  Future<void> call(GroupEntity groupEntity) {
    return repository.updateGroup(groupEntity);
  }
}
