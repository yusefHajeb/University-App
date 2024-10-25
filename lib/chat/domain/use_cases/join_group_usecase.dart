import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class JoinGroupUseCase {
  final DatabaseRepository repository;

  JoinGroupUseCase({required this.repository});

  Future<void> call(GroupEntity groupEntity) async {
    return await repository.joinGroup(groupEntity);
  }
}
