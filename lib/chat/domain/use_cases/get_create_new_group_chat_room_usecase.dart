import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetCreateNewGroupChatRoomUseCase {
  final DatabaseRepository repository;

  GetCreateNewGroupChatRoomUseCase({required this.repository});

  Future<void> call(MyChatEntity myChatEntity, List<String> selectUserList) {
    return repository.getCreateNewGroupChatRoom(myChatEntity, selectUserList);
  }
}
