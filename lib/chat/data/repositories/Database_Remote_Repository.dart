import 'dart:io';

import 'package:university/chat/data/remote/data_sources/Database_Remote_Data_Source.dart';
import 'package:university/chat/domain/entities/engage_user_entity.dart';
import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/repositories/database_Repositorys.dart';

class DatabaseRemoteDataSourceImpl implements DatabaseRepository {
  final DatabaseRemoteDataSource remoteDataSource;

  DatabaseRemoteDataSourceImpl({required this.remoteDataSource});

  @override
  Future<void> getCreateCurrentUser(StudentEntity user) async =>
      await remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<StudentEntity> getCurrentUId(StudentEntity user) async =>
      await remoteDataSource.getCurrentUId(user);

  @override
  Future<bool> isSignIn() async => await remoteDataSource.isSignIn();

  @override
  Future<void> signInWithPhoneNumber(String pinCode) async =>
      await remoteDataSource.signInWithPhoneNumber(pinCode);

  @override
  Future<void> signOut() async => await remoteDataSource.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await remoteDataSource.verifyPhoneNumber(phoneNumber);
  }

  @override
  Stream<List<StudentEntity>> getAllUsers(int batch_id) =>
      remoteDataSource.getAllUsers(batch_id);

  @override
  Future<String> createOneToOneChatChannel(
          EngageUserEntity engageUserEntity) async =>
      remoteDataSource.createOneToOneChatChannel(engageUserEntity);

  @override
  Future<bool> sendTextMessage(
      TextMessageEntity textMessageEntity, int channelId) async {
    return await remoteDataSource.sendTextMessage(textMessageEntity, channelId);
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(int channelId) {
    return remoteDataSource.getMessages(channelId);
  }

  @override
  Future<String> getChannelId(EngageUserEntity engageUserEntity) async {
    return remoteDataSource.getChannelId(engageUserEntity);
  }

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) async {
    return await remoteDataSource.addToMyChat(myChatEntity);
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(int uid) {
    return remoteDataSource.getMyChat(uid);
  }

  @override
  Future<void> createNewGroup(
      MyChatEntity myChatEntity, List<String> selectUserList) {
    return remoteDataSource.createNewGroup(myChatEntity, selectUserList);
  }

  @override
  Future<void> getCreateNewGroupChatRoom(
      MyChatEntity myChatEntity, List<String> selectUserList) {
    return remoteDataSource.createNewGroup(myChatEntity, selectUserList);
  }

  @override
  Future<void> googleAuth() async => remoteDataSource.googleAuth();

  @override
  Future<void> forgotPassword(String email) async =>
      remoteDataSource.forgotPassword(email);

  @override
  Future<bool> signIn(StudentEntity user) async =>
      remoteDataSource.signIn(user);

  @override
  Future<void> signUp(StudentEntity user) async =>
      remoteDataSource.signUp(user);

  @override
  Future<void> getUpdateUser(StudentEntity user) async =>
      remoteDataSource.getUpdateUser(user);

  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) async =>
      remoteDataSource.getCreateGroup(groupEntity);

  @override
  Stream<List<GroupEntity>> getGroups(int batch_id) =>
      remoteDataSource.getGroups(batch_id);

  @override
  Future<void> joinGroup(GroupEntity groupEntity) async =>
      remoteDataSource.joinGroup(groupEntity);

  @override
  Future<void> updateGroup(GroupEntity groupEntity) async =>
      remoteDataSource.updateGroup(groupEntity);

  @override
  Future<int> NumberMessagenotseen() async =>
      remoteDataSource.numbermessagenotseen();

  @override
  Stream<List<GroupEntity>> getGroupslocl() => remoteDataSource.getGroupslocl();

  @override
  Future<String> sendFileMessage(TextMessageEntity textMessageEntity,
      int channelId, File file, int type_message) {
    // TODO: implement sendImageTextMessage
    return remoteDataSource.sendFileMessage(
        textMessageEntity, channelId, file, type_message);
  }

  @override
  Future<bool> updateTextMessage(TextMessageEntity textMessageEntity) {
    return remoteDataSource.updateTextMessage(textMessageEntity);
  }

  @override
  Future<bool> deleteTextMessage(TextMessageEntity textMessageEntity) {
    return remoteDataSource.deleteTextMessage(textMessageEntity);
  }

  @override
  Future<bool> storetoken(int t_id) {
    return remoteDataSource.storetoken(t_id);
  }
}
