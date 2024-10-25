import 'dart:io';

import 'package:university/chat/domain/entities/engage_user_entity.dart';
import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';

abstract class DatabaseRepository {
  Future<void> getCreateCurrentUser(StudentEntity user);
  Future<void> googleAuth();
  Future<void> forgotPassword(String email);

  Future<void> getCreateGroup(GroupEntity groupEntity);
  Stream<List<GroupEntity>> getGroups(int batch_id);
  Stream<List<GroupEntity>> getGroupslocl();

  Future<void> joinGroup(GroupEntity groupEntity);
  Future<void> updateGroup(GroupEntity groupEntity);

  Future<bool> isSignIn();
  Future<bool> storetoken(int t_id);
  Future<bool> signIn(StudentEntity user);
  Future<void> signUp(StudentEntity user);
  Future<void> signOut();
  Future<void> getUpdateUser(StudentEntity user);
  Future<StudentEntity> getCurrentUId(StudentEntity user);
  Stream<List<StudentEntity>> getAllUsers(int batch_id);
  Future<String> createOneToOneChatChannel(EngageUserEntity engageUserEntity);
  Future<String> getChannelId(EngageUserEntity engageUserEntity);
  Future<void> createNewGroup(
      MyChatEntity myChatEntity, List<String> selectUserList);
  Future<void> getCreateNewGroupChatRoom(
      MyChatEntity myChatEntity, List<String> selectUserList);
  Future<bool> sendTextMessage(
      TextMessageEntity textMessageEntity, int channelId);
  Future<bool> updateTextMessage(TextMessageEntity textMessageEntity);
  Future<bool> deleteTextMessage(TextMessageEntity textMessageEntity);

  Future<String> sendFileMessage(TextMessageEntity textMessageEntity,
      int channelId, File file, int type_message);
  Stream<List<TextMessageEntity>> getMessages(int channelId);
  Future<void> addToMyChat(MyChatEntity myChatEntity);
  Stream<List<MyChatEntity>> getMyChat(int uid);
  Future<int> NumberMessagenotseen();
}
