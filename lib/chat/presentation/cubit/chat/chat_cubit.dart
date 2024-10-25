import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/use_cases/delete_message_usecase.dart';
import 'package:university/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:university/chat/domain/use_cases/send_file_messag_usecase.dart';
import 'package:university/chat/domain/use_cases/send_text_message_usecase.dart';
import 'package:university/chat/domain/use_cases/update_text_message.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetMessageUseCase getMessageUseCase;
  final SendFileMessageUseCase sendfileMessageUseCase;
  final UpdateMyTextMessage updateMyTextMessage;
  final DeleteMyTextMessage deleteMyTextMessage;
  ChatCubit(
      {required this.getMessageUseCase,
      required this.sendTextMessageUseCase,
      required this.sendfileMessageUseCase,
      required this.updateMyTextMessage,
      required this.deleteMyTextMessage})
      : super(ChatInitial());

  StreamSubscription<List<TextMessageEntity>>? streamSubscription;
  Future<void> getMessages({required int channelId}) async {
    emit(ChatLoading());
    try {
      final streamResponse = getMessageUseCase.call(channelId);
      streamSubscription = streamResponse.listen((messages) {
        emit(ChatLoaded(messages: messages));
      });
    } catch (_) {
      emit(ChatFailure());
    }
  }

  Future<void> sendTextMessage(
      {required TextMessageEntity textMessageEntity,
      required int channelId}) async {
    try {
      if (await sendTextMessageUseCase.call(textMessageEntity, channelId)) {
        if (state is ChatLoaded) {
          print("no sent");
          textMessageEntity.isSend = true;
          final List<TextMessageEntity> updatedMessages =
              (state as ChatLoaded).messages.toList()..add(textMessageEntity);
          emit(ChatLoaded(messages: updatedMessages));
        }
      } else {
        print("no sent for eles");
        final List<TextMessageEntity> updatedMessages =
            (state as ChatLoaded).messages.toList()..add(textMessageEntity);
        emit(ChatLoaded(messages: updatedMessages));
      }
    } on SocketException catch (_) {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }

  Future<void> updateTextMessage({
    required TextMessageEntity textMessageEntity,
  }) async {
    try {
      if (await updateMyTextMessage.call(textMessageEntity)) {
        if (state is ChatLoaded) {
          textMessageEntity.isSend = true;
          final List<TextMessageEntity> updatedMessages =
              (state as ChatLoaded).messages.toList();
          final int messageIndex = updatedMessages.indexWhere(
              (message) => message.messageId == textMessageEntity.messageId);
          if (messageIndex != -1) {
            updatedMessages[messageIndex] = textMessageEntity;
          } else {
            updatedMessages.add(textMessageEntity);
          }
          emit(ChatLoaded(messages: updatedMessages));
        }
      } else {
        final List<TextMessageEntity> updatedMessages =
            (state as ChatLoaded).messages.toList()..add(textMessageEntity);
        emit(ChatLoaded(messages: updatedMessages));
      }
    } on SocketException catch (_) {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }

  Future<void> deleteTextMessage({
    required TextMessageEntity textMessageEntity,
  }) async {
    try {
      print("here in deleteTextMessage");
      if (await deleteMyTextMessage.call(textMessageEntity)) {
        if (state is ChatLoaded) {
          final List<TextMessageEntity> updatedMessages =
              (state as ChatLoaded).messages.toList();
          final int messageIndex = updatedMessages.indexWhere(
              (message) => message.messageId == textMessageEntity.messageId);
          if (messageIndex != -1) {
            updatedMessages.removeAt(messageIndex);
          }
          print("???????done delete ");
          emit(ChatLoaded(messages: updatedMessages));
        } else {
          print("here in deleteTextMessage else ChatLoaded");
        }
      } else {
        print("here in deleteTextMessage else");
      }
    } on SocketException catch (_) {
      print("here in SocketException");

      emit(ChatFailure());
    } catch (_) {
      print("here in catch ");
      emit(ChatFailure());
    }
  }

  Future<void> refreshMessages(
      {required int channelId, required int sender}) async {}

  Future<void> sendFileMessage({
    required File file,
    required TextMessageEntity textMessageEntity,
    required int channelId,
    required int type_message,
  }) async {
    var result = await sendfileMessageUseCase.call(
        textMessageEntity, channelId, file, type_message);

    if (result != "") {
      print(result);
      textMessageEntity.isSend = true;
      textMessageEntity.url_madia = result;
      final List<TextMessageEntity> updatedMessages =
          (state as ChatLoaded).messages.toList()..add(textMessageEntity);
      emit(ChatLoaded(messages: updatedMessages));
    } else {
      print("no sent for eles");
      final List<TextMessageEntity> updatedMessages =
          (state as ChatLoaded).messages.toList()..add(textMessageEntity);
      emit(ChatLoaded(messages: updatedMessages));
    }
  }
}
