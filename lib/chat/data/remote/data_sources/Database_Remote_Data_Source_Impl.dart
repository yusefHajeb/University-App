import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/chat/data/remote/data_sources/DataAccess.dart';
import 'package:university/chat/data/remote/data_sources/Database_Remote_Data_Source.dart';
import 'package:university/chat/data/remote/models/group_model.dart';
import 'package:university/chat/data/remote/models/text_message_model.dart';
import 'package:university/chat/data/remote/models/student_model.dart';
import 'package:university/chat/domain/entities/student_entity.dart';
import 'package:university/chat/domain/entities/text_messsage_entity.dart';
import 'package:university/chat/domain/entities/my_chat_entity.dart';
import 'package:university/chat/domain/entities/group_entity.dart';
import 'package:university/chat/domain/entities/engage_user_entity.dart';
import 'package:university/generated/Links.dart';
import 'package:university/generated/Netwrok.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class databaseRemoteDataSourceImpl implements DatabaseRemoteDataSource {
  final DataAccessCrud crud;
  final SharedPreferences prefs;
  final NetworkInfoSocket networkinfo;
  final IO.Socket socket;
  databaseRemoteDataSourceImpl({
    required this.networkinfo,
    required this.crud,
    required this.prefs,
    required this.socket,
  });
  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) {
    // TODO: implement addToMyChat
    throw UnimplementedError();
  }

  @override
  Future<void> createCurrentUser(StudentEntity user) {
    // TODO: implement createCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<void> createGroup(GroupEntity groupEntity) {
    // TODO: implement createGroup
    throw UnimplementedError();
  }

  @override
  Future<void> createNewGroup(
      MyChatEntity myChatEntity, List<String> selectUserList) {
    // TODO: implement createNewGroup
    throw UnimplementedError();
  }

  @override
  Future<String> createOneToOneChatChannel(
      EngageUserEntity engageStudentEntity) {
    // TODO: implement createOneToOneChatChannel
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Stream<List<StudentEntity>> getAllUsers(int batch_id) async* {
    if (await networkinfo.conected) {
      try {
        var url = linkPuplicNodeServerName + '/getStudent';
        var response = await crud.PostRequset(url, {"batch_id": '${batch_id}'});
        if (response != null) {
          if (response["data"] is List) {
            yield List<StudentEntity>.from(response["data"]
                .map((userData) => StudentModel.fromJson(userData))
                .toList());
            String jsonString = jsonEncode(response["data"]);
            await prefs.setString('StudentList', jsonString);
          } else {
            yield [];
          }
        } else {
          yield [];
        }
      } catch (e) {
        yield [];
      }
    } else {
      print("getAllUsers offline");
      String? storedJsonString = prefs.getString('StudentList');
      if (storedJsonString != null) {
        List<dynamic> storedList = jsonDecode(storedJsonString);
        List<StudentEntity> storedMessageList = storedList
            .map<StudentEntity>((item) => StudentModel.fromJson(item))
            .toList();
        yield storedMessageList;
      } else {
        yield [];
      }
    }
  }

  @override
  Future<String> getChannelId(EngageUserEntity engageStudentEntity) {
    // TODO: implement getChannelId linkgetAllGoups

    throw UnimplementedError();
  }

  @override
  Stream<List<GroupEntity>> getGroups(int batch_id) async* {
    if (await networkinfo.conected) {
      try {
        var url = linkPuplicNodeServerName + "/getGroup";
        var response = await crud.PostRequset(url, {"batch_id": '${batch_id}'});
        if (response != null) {
          if (response["data"] is List) {
            yield List<GroupEntity>.from(response["data"]
                .map((userData) => GroupModel.fromJson(userData))
                .toList());
            String jsonString = jsonEncode(response["data"]);
            await prefs.setString('GroupList', jsonString);
            print("From Node js تم حفظ بيانات القروب");
          } else {
            String? storedJsonString = prefs.getString('GroupList');
            if (storedJsonString != null) {
              List<dynamic> storedList = jsonDecode(storedJsonString);
              List<GroupEntity> storedGroupList = storedList
                  .map<GroupEntity>((item) => GroupModel.fromJson(item))
                  .toList();
              yield storedGroupList;
            } else {
              yield [];
            }
          }
        } else {
          String? storedJsonString = prefs.getString('GroupList');
          if (storedJsonString != null) {
            List<dynamic> storedList = jsonDecode(storedJsonString);
            List<GroupEntity> storedGroupList = storedList
                .map<GroupEntity>((item) => GroupModel.fromJson(item))
                .toList();
            yield storedGroupList;
          } else {
            yield [];
          }
        }
      } catch (e) {
        String? storedJsonString = prefs.getString('GroupList');
        if (storedJsonString != null) {
          List<dynamic> storedList = jsonDecode(storedJsonString);
          List<GroupEntity> storedGroupList = storedList
              .map<GroupEntity>((item) => GroupModel.fromJson(item))
              .toList();
          yield storedGroupList;
        } else {
          yield [];
        }
      }
    } else {
      String? storedJsonString = prefs.getString('GroupList');
      if (storedJsonString != null) {
        List<dynamic> storedList = jsonDecode(storedJsonString);
        List<GroupEntity> storedMessageList = storedList
            .map<GroupEntity>((item) => GroupModel.fromJson(item))
            .toList();
        yield storedMessageList;
      } else {
        yield [];
      }
    }
  }

  String getUserMessageIdKey(int userId) {
    return "lastmessageId_user_$userId";
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(int channelId) async* {
    if (await networkinfo.conected) {
      try {
        var response = await crud.PostRequset(
            linkNodegetMessageGoups, {"channelId": '${channelId}'});
        if (response["status"] == "success") {
          if (response["data"] is List) {
            int lastMessageId = 0;
            List<TextMessageEntity> messageList =
                response["data"].map<TextMessageEntity>((messageData) {
              lastMessageId =
                  messageData["messageId"]; // تفتيش رقم الرسالة الأولى
              return TextMessageModel.fromJson(messageData);
            }).toList();
            String jsonString = jsonEncode(response["data"]);
            await prefs.setString('messageList', jsonString);
            // حفظ رقم آخر رسالة في SharedPreferences
            var myId = prefs.getInt("std_id");
            await prefs.setInt(getUserMessageIdKey(myId!), lastMessageId);
            yield messageList;
          } else {
            yield [];
          }
        } else {
          String? storedJsonString = prefs.getString('messageList');
          if (storedJsonString != null) {
            List<dynamic> storedList = jsonDecode(storedJsonString);
            List<TextMessageEntity> storedMessageList = storedList
                .map<TextMessageEntity>(
                    (item) => TextMessageModel.fromJson(item))
                .toList();
            yield storedMessageList;
          } else {
            yield [];
          }
        }
      } catch (e) {
        print("dssssssssssssssssssssssssssssss catch");
        String? storedJsonString = prefs.getString('messageList');
        if (storedJsonString != null) {
          List<dynamic> storedList = jsonDecode(storedJsonString);
          List<TextMessageEntity> storedMessageList = storedList
              .map<TextMessageEntity>((item) => TextMessageModel.fromJson(item))
              .toList();
          yield storedMessageList;
        } else {
          yield [];
        }
      }
    } else {
      print("dssssssssssssssssssssssssssssss catch");
      String? storedJsonString = prefs.getString('messageList');
      if (storedJsonString != null) {
        List<dynamic> storedList = jsonDecode(storedJsonString);
        List<TextMessageEntity> storedMessageList = storedList
            .map<TextMessageEntity>((item) => TextMessageModel.fromJson(item))
            .toList();
        yield storedMessageList;
      } else {
        yield [];
      }
    }
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(int userId) {
    // TODO: implement getMyChat
    throw UnimplementedError();
  }

  @override
  Future<void> googleAuth() {
    // TODO: implement googleAuth
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() async {
    // TODO: implement isSignedIn
    return true;
  }

  @override
  Future<void> joinGroup(GroupEntity groupEntity) {
    // TODO: implement joinGroup
    throw UnimplementedError();
  }

  @override
  Future<bool> sendTextMessage(
      TextMessageEntity textMessageEntity, int channelId) async {
    if (socket.connected) {
      try {
        socket.emit(
          "Sendmessage",
          {
            'channellId': '${channelId}',
            'senderProfile': textMessageEntity.senderProfile,
            'senderId': textMessageEntity.senderId,
            'senderName': textMessageEntity.senderName,
            'type_message': textMessageEntity.type,
            'time': DateFormat('yyyy-MM-ddTHH:mm:ss')
                .format(textMessageEntity.time!),
            'content': textMessageEntity.content,
            'url_madia': "not found",
            'messageId': textMessageEntity.messageId,
          },
        );
        final url = NodelinksendMessageGoups;
        var response = await crud.PostRequset(url, {
          "channelId": '${channelId}',
          "senderId": '${textMessageEntity.senderId}',
          "type_message": '${1}',
          "content": '${textMessageEntity.content}',
          "time": '${textMessageEntity.time}',
          "url_madia": "not found"
        });
        if (response["status"] == "success") {
          // تم التحقق بنجاح
          // print(response["messageId"]);
          // // حفظ رقم آخر رسالة في SharedPreferences
          // var myId = prefs.getInt("std_id");
          // var lastM = int.parse(response["messageId"]);
          // await prefs.setInt(getUserMessageIdKey(myId!), lastM);
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print('حدث خطأ أثناء التحقق: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> signIn(StudentEntity user) async {
    try {
      var response = await crud.PostRequset(linkNodeSignin,
          {"record": '${user.std_record}', "password": user.std_password});
      if (response["status"] == "success") {
        await prefs.setString("email", user.std_email);
        await prefs.setString("password", user.std_password);
        await prefs.setInt("record", user.std_record);
        await prefs.setBool("isLoggedIn", true);
        // تم التحقق بنجاح
        print('تم التحقق بنجاح');
        return true;
      } else {
        // فشل التحقق
        print('فشل التحقق. يرجى التحقق من البريد الإلكتروني وكلمة المرور');
        return false;
      }
    } catch (e) {
      print('حدث خطأ أثناء التحقق: $e');
      return false;
    }
  }

  @override
  Future<void> signInWithPhoneNumber(String pinCode) {
    // TODO: implement signInWithPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await prefs.clear();
  }

  @override
  Future<void> signUp(StudentEntity user) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<void> updateGroup(GroupEntity groupEntity) async {
    // try {
    //   // إنشاء URL للاتصال بملف PHP الخاص بالتحقق من البريد الإلكتروني وكلمة المرور
    //   final url = linkSignin;
    //   // إنشاء طلب POST وإرسال بيانات المستخدم (بريد إلكتروني وكلمة مرور)
    //   var response = await crud.PostRequset(
    //       linkSignin, {"groupId": '${groupEntity.groupId}', "lastMessage": '${groupEntity.lastMessage}'});
    //   if (response["status"] == "success") {
    //     // تم التحقق بنجاح
    //     print('تم التحقق بنجاح');
    //   } else {
    //     // فشل التحقق
    //     print('فشل التحقق. يرجى التحقق من البريد الإلكتروني وكلمة المرور');
    //   }
    // } catch (e) {
    //   print('حدث خطأ أثناء التحقق: $e');
    // }
  }

  @override
  Future<void> updateUser(StudentEntity user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) {
    // TODO: implement verifyPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> getCreateCurrentUser(StudentEntity user) {
    // TODO: implement getCreateCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) {
    // TODO: implement getCreateGroup
    throw UnimplementedError();
  }

  @override
  Future<StudentEntity> getCurrentUId(StudentEntity user) async {
    try {
      final url = linkNodeGetCurrentSId;
      var response = await crud.PostRequset(
          url, {"record": '${user.std_record}', "password": user.std_password});
      if (response["status"] == "success") {
        // تم تحميل جميع البيانات الخاصة بك
        var i = new StudentEntity(
            std_image: response["data"][0]["std_image"],
            std_name: response["data"][0]["std_name"],
            batch_id: response["data"][0]["batch_id"],
            t_id: response["data"][0]["t_id"],
            std_email: response["data"][0]["std_email"]);
        print('تم تحميل البيانات بنجاح');
        await prefs.setInt("std_id", response["data"][0]["t_id"]);
        await prefs.setInt("batch_id", response["data"][0]["batch_id"]);
        await prefs.setString("std_name", response["data"][0]["std_name"]);
        await prefs.setString("std_image", response["data"][0]["std_image"]);
        return i;
      } else {
        return Future.error('حدث خطأ أثناء التحقق');
      }
    } catch (e) {
      print('حدث خطأ أثناء التحقق: $e');
      return Future.error('حدث خطأ أثناء التحقق: $e');
    }
    // } else {
    //   print('تم تحميل البيانات بنجاح sherd:');
    //   var i = new StudentEntity(
    //     std_name: prefs.getString("std_name")!,
    //     batch_id: prefs.getInt("batch_id")!,
    //     t_id: prefs.getInt("std_id")!,
    //     std_image: prefs.getString("std_image")!,
    //   );
    //   return i;
    // }
  }

  @override
  Future<void> getUpdateUser(StudentEntity user) {
    // TODO: implement getUpdateUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignIn() async {
    try {
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      return isLoggedIn;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Future<int> numbermessagenotseen() async {
    if (await networkinfo.conected) {
      try {
        socket.connect();
        var i = 0;
        var myId = prefs.getInt("std_id");
        var lastMessageId = prefs.getInt(getUserMessageIdKey(myId!));
        socket.emit('ConuntNewMessage',
            {"channelId": '${12}', "messageId": '${lastMessageId}'});
        socket.on('reslCount', (data) async {
          // var response = data;
          // if (response != null) {
          //   print("*************" + response[0]["rowCount"]);
          //   i = response[0]["rowCount"];
          //   await prefs.setInt("rowCount", i);
          //   return i;
          // } else {
          //   // فشل التحقق
          //   print('فشل التحقق. يرجى التحقق من البريد الإلكتروني وكلمة المرور');
          //   return 0;
          // }
          return 1;
        });
        return await prefs.getInt("rowCount")!;
      } catch (e) {
        print('حدث خطأ أثناء التحقق: $e');
        return 0;
      }
    } else {
      int rowCount = await prefs.getInt("rowCount")!;
      return await prefs.getInt("rowCount")!;
    }
  }

  @override
  Stream<List<GroupEntity>> getGroupslocl() async* {
    String? storedJsonString = prefs.getString('GroupList');
    print('Stored JSON String: $storedJsonString');
    if (storedJsonString != null) {
      List<dynamic> storedList = jsonDecode(storedJsonString);
      List<GroupEntity> storedGroupList = storedList
          .map<GroupEntity>((item) => GroupModel.fromJson(item))
          .toList();
      print('Stored Group List: $storedGroupList');
      yield storedGroupList;
    } else {
      print('No stored data found');
      yield [];
    }
  }

  @override
  Future<String> sendFileMessage(TextMessageEntity textMessageEntity,
      int channelId, File file, int type_message) async {
    if (socket.connected) {
      try {
        final url = linkUplodeNode;
        var response = await crud.PostRequsetWithFile(
            url,
            {
              "channelId": '${channelId}',
              "senderId": '${textMessageEntity.senderId}',
              "type_message": '${type_message}',
              "content": textMessageEntity.content,
              "time": '${textMessageEntity.time}',
              "url_madia": textMessageEntity.url_madia
            },
            file);
        socket.emit(
          "Sendmessage",
          {
            'channellId': '${channelId}',
            'senderProfile': textMessageEntity.senderProfile,
            'senderId': textMessageEntity.senderId,
            'senderName': textMessageEntity.senderName,
            'type_message': textMessageEntity.type,
            'time': DateFormat('yyyy-MM-ddTHH:mm:ss')
                .format(textMessageEntity.time!),
            'content': textMessageEntity.content,
            'url_madia': textMessageEntity.url_madia,
            'messageId': textMessageEntity.messageId
          },
        );
        if (response["status"] == "success") {
          // تم التحقق بنجاح

          // حفظ رقم آخر رسالة في SharedPreferences
          // var myId = prefs.getInt("std_id");
          // var lastM = int.parse(response["messageId"]);
          // await prefs.setInt(getUserMessageIdKey(myId!), lastM);
          return response["data"];
        } else {
          return "";
        }
      } catch (e) {
        print('حدث خطأ أثناء التحقق: $e');
        return "";
      }
    } else {
      return "";
    }
  }

  @override
  Future<bool> updateTextMessage(TextMessageEntity textMessageEntity) async {
    if (socket.connected) {
      try {
        socket.emit(
          "Updatemessage",
          {
            'channellId': '${textMessageEntity.channellId}',
            'senderProfile': textMessageEntity.senderProfile,
            'senderId': textMessageEntity.senderId,
            'senderName': textMessageEntity.senderName,
            'type_message': textMessageEntity.type,
            'time': DateFormat('yyyy-MM-ddTHH:mm:ss')
                .format(textMessageEntity.time!),
            'content': textMessageEntity.content,
            'url_madia': "not found",
            'messageId': textMessageEntity.messageId,
          },
        );
        const url = NodelinkupdateMessageGoups;
        var response = await crud.PostRequset(url, {
          "messageId": '${textMessageEntity.messageId}',
          "senderId": '${textMessageEntity.senderId}',
          "type_message": '${1}',
          "content": '${textMessageEntity.content}',
          "time": '${textMessageEntity.time}',
          "url_madia": "not found"
        });
        if (response["status"] == "success") {
          // تم التحقق بنجاح
          // print(response["messageId"]);
          // // حفظ رقم آخر رسالة في SharedPreferences
          // var myId = prefs.getInt("std_id");
          // var lastM = int.parse(response["messageId"]);
          // await prefs.setInt(getUserMessageIdKey(myId!), lastM);
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print('حدث خطأ أثناء التحقق: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteTextMessage(TextMessageEntity textMessageEntity) async {
    if (socket.connected) {
      try {
        socket.emit(
          "deletemessage",
          {
            'channellId': '${textMessageEntity.channellId}',
            'senderProfile': textMessageEntity.senderProfile,
            'senderId': textMessageEntity.senderId,
            'senderName': textMessageEntity.senderName,
            'type_message': textMessageEntity.type,
            'time': DateFormat('yyyy-MM-ddTHH:mm:ss')
                .format(textMessageEntity.time!),
            'content': textMessageEntity.content,
            'url_madia': "not found",
            'messageId': textMessageEntity.messageId,
          },
        );
        print(textMessageEntity.content);
        final url = NodelinkdeleteMessageGoups;
        var response = await crud.PostRequset(url, {
          "messageId": '${textMessageEntity.messageId}',
        });
        if (response["status"] == "success") {
          print("تم X بنجاح");
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print('حدث خطأ أثناء التحقق: $e');
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> storetoken(int t_id) async {
    if (await socket.connected) {
      var token = await prefs.getString("token")!;
      var response = await crud.PostRequset(linkUpdatetoken, {
        "t_id": '${t_id}',
        "token": '${prefs.getString("token")!}',
      });
      if (response['status'] == 'success') {
        print(token);
        return true;
      }
      return false;
    } else {}
    return false;
  }
}
