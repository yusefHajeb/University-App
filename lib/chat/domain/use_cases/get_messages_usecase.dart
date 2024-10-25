import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class GetMessageUseCase {
  final DatabaseRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(int channelId) {
    return repository.getMessages(channelId);
  }
}
