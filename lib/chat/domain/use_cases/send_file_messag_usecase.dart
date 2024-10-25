import 'dart:io';

import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class SendFileMessageUseCase {
  final DatabaseRepository repository;

  SendFileMessageUseCase({required this.repository});

  Future<String> call(TextMessageEntity textMessageEntity, int channelId,
      File file, int type_message) async {
    return await repository.sendFileMessage(
        textMessageEntity, channelId, file, type_message);
  }
}
