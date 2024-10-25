import 'package:equatable/equatable.dart';

class TextMessageEntity extends Equatable {
  final int? recipientId = 0;
  final int? senderId;
  final String? senderName;
  final String? senderProfile;
  final String? type;
  final DateTime? time;
  final String? content;
  String? url_madia;
  final int? messageId;
  final int? channellId;
  bool? isSend;

  TextMessageEntity({
    this.senderProfile,
    this.senderId,
    this.senderName,
    this.type,
    this.time,
    this.content,
    this.url_madia,
    this.messageId,
    this.channellId,
    this.isSend,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        recipientId!,
        senderId!,
        senderName!,
        type!,
        time!,
        content!,
        url_madia!,
        messageId!,
        senderProfile!,
        isSend!
      ];
}

enum Type { TEXT, IMAGE }
