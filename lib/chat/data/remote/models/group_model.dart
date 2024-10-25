import 'package:equatable/equatable.dart';
import 'package:university/chat/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  GroupModel({
    final String groupName = "",
    final String groupProfileImage = "",
    final String admin = "",
    final String limitUsers = "",
    final int uid = 0,
    final DateTime? creationTime,
    final int groupId = 0,
    final String lastMessage = "",
    final DateTime? TimelastMessage,
  }) : super(
            groupName: groupName,
            creationTime: creationTime,
            groupId: groupId,
            groupProfileImage: groupProfileImage,
            adminName: admin,
            limitUsers: limitUsers,
            uid: uid,
            lastMessage: lastMessage,
            TimelastMessage: TimelastMessage);

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        groupName: json['groupName'],
        creationTime: DateTime.tryParse(json['creationTime']),
        groupId: json['groupId'],
        groupProfileImage: json['groupProfileImage'],
        lastMessage: json['lastMessage'],
        uid: json['std_admin_id'],
        admin: json['adminName'],
        TimelastMessage: DateTime.tryParse(json['TimelastMessage']));
  }
}
