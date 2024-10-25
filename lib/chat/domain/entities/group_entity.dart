import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String groupName;
  final String groupProfileImage;
  final String adminName;
  final String limitUsers;
  final DateTime? creationTime;
  final int groupId;
  final int uid;
  final String lastMessage;
  final DateTime? TimelastMessage;

  GroupEntity({
    this.groupName = "",
    this.groupProfileImage = "",
    this.adminName = "",
    this.limitUsers = "",
    this.creationTime,
    this.groupId = 0,
    this.uid = 0,
    this.lastMessage = "",
    this.TimelastMessage,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        groupName,
        groupProfileImage,
        adminName,
        uid,
        limitUsers,
        creationTime!,
        groupId,
        lastMessage,
        TimelastMessage!,
      ];
}
