import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class SendTextMessageUseCase {
  final DatabaseRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<bool> call(TextMessageEntity textMessageEntity, int channelId) async {
    return await repository.sendTextMessage(textMessageEntity, channelId);
  }
}
