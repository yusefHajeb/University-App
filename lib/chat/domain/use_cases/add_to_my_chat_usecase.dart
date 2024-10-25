import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class AddToMyChatUseCase {
  final DatabaseRepository repository;

  AddToMyChatUseCase({required this.repository});

  Future<void> call(MyChatEntity myChatEntity) async {
    return await repository.addToMyChat(myChatEntity);
  }
}
