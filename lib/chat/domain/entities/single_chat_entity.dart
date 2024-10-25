class SingleChatEntity {
  final int groupId;
  final int batch_id;
  final String groupName;
  final int uid;
  final String username;
  final String groupProfileImage;
  final String MyProfileImage;
  final String adminName;

  SingleChatEntity(
      {required this.adminName,
      required this.MyProfileImage,
      required this.username,
      required this.groupId,
      required this.groupName,
      required this.uid,
      required this.batch_id,
      required this.groupProfileImage});
}
