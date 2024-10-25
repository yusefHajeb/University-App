import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class UpdateMyTextMessage {
  final DatabaseRepository repository;

  UpdateMyTextMessage({required this.repository});

  Future<bool> call(TextMessageEntity textMessageEntity) async {
    return await repository.updateTextMessage(textMessageEntity);
  }
}
