import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class DeleteMyTextMessage {
  final DatabaseRepository repository;

  DeleteMyTextMessage({required this.repository});

  Future<bool> call(TextMessageEntity textMessageEntity) async {
    return await repository.deleteTextMessage(textMessageEntity);
  }
}
