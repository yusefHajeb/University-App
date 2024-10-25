import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetMyChatUseCase {
  final DatabaseRepository repository;

  GetMyChatUseCase({required this.repository});

  Stream<List<MyChatEntity>> call(int uid) {
    return repository.getMyChat(uid);
  }
}
