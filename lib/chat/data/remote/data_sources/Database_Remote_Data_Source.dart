import 'dart:io';

import 'package:university/chat/domain/entities/engage_user_entity.dart';
import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';

abstract class DatabaseRemoteDataSource {
  Future<void> verifyPhoneNumber(String phoneNumber);

  Future<void> getCreateCurrentUser(StudentEntity user);
  Future<void> getCreateGroup(GroupEntity groupEntity);
  Future<void> joinGroup(GroupEntity groupEntity);
  Future<void> updateGroup(GroupEntity groupEntity);
  Stream<List<GroupEntity>> getGroups(int batch_id);
  Stream<List<GroupEntity>> getGroupslocl();

  Future<void> signInWithPhoneNumber(String pinCode);

  Future<void> forgotPassword(String email);

  Future<bool> signIn(StudentEntity user);
  Future<bool> storetoken(int t_id);

  Future<void> signUp(StudentEntity user);

  Future<void> getUpdateUser(StudentEntity user);

  Future<void> googleAuth();

  Future<bool> isSignIn();

  Future<void> signOut();

  Future<StudentEntity> getCurrentUId(StudentEntity user);

  Stream<List<StudentEntity>> getAllUsers(int batch_id);

  Future<String> createOneToOneChatChannel(EngageUserEntity engageUserEntity);

  Future<String> getChannelId(EngageUserEntity engageUserEntity);

  Future<bool> sendTextMessage(
      TextMessageEntity textMessageEntity, int channelId);
  Future<bool> deleteTextMessage(TextMessageEntity textMessageEntity);

  Future<bool> updateTextMessage(TextMessageEntity textMessageEntity);
  Future<String> sendFileMessage(TextMessageEntity textMessageEntity,
      int channelId, File file, int type_message);

  Stream<List<TextMessageEntity>> getMessages(int channelId);

  Future<void> addToMyChat(MyChatEntity myChatEntity);

  Future<void> createNewGroup(
      MyChatEntity myChatEntity, List<String> selectUserList);

  Stream<List<MyChatEntity>> getMyChat(int uid);
  Future<int> numbermessagenotseen();
}
