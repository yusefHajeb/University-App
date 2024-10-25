import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetAllGroupsUseCase {
  final DatabaseRepository repository;

  GetAllGroupsUseCase({required this.repository});

  Stream<List<GroupEntity>> call(int batch_id) {
    return repository.getGroups(batch_id);
  }

  Stream<List<GroupEntity>> locl() {
    return repository.getGroupslocl();
  }
}
