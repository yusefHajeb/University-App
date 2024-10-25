import 'package:university/chat/domain/entities/text_messsage_entity.dart';

class TextMessageModel extends TextMessageEntity {
  TextMessageModel({
    int? recipientId = 0,
    int? senderId,
    String? senderName,
    String? senderProfile,
    String? type,
    DateTime? time,
    String? content,
    String? url_madia = "",
    int? messageId,
    int? channellId,
    bool isSend = true,
  }) : super(
            senderProfile: senderProfile,
            senderId: senderId,
            senderName: senderName,
            type: type,
            time: time,
            content: content,
            url_madia: url_madia,
            messageId: messageId,
            channellId: channellId,
            isSend: isSend);

  factory TextMessageModel.fromJson(Map<String, dynamic> json) {
    return TextMessageModel(
        senderProfile: json['senderProfile'],
        senderId: json['senderId'],
        senderName: json['senderName'],
        type: json['type_message'],
        time: DateTime.parse(json['time']),
        content: json['content'],
        url_madia: json['url_madia'],
        messageId: json['messageId'],
        channellId: json['chanellid']);
  }

  Map<String, dynamic> toJson() {
    return {
      'senderProfile': senderProfile,
      'senderId': senderId,
      'senderName': senderName,
      'type_message': type,
      'time': time,
      'content': content,
      'url_madia': url_madia,
      'messageId': messageId,
    };
  }
  // factory TextMessageModel.fromSnapshot(DocumentSnapshot snapshot) {
  //   return TextMessageModel(
  //     recipientId: snapshot.get('recipientId'),
  //     senderId: snapshot.get('senderId'),
  //     senderName: snapshot.get('senderName'),
  //     type: snapshot.get('type'),
  //     time: snapshot.get('time'),
  //     content: snapshot.get('content'),
  //     receiverName: snapshot.get('receiverName'),
  //     messageId: snapshot.get('messageId'),
  //   );
  // }

  Map<String, dynamic> toDocument() {
    return {
      "recipientId": recipientId,
      "senderId": senderId,
      "senderName": senderName,
      "type_message": type,
      "time": time,
      "content": content,
      "url_madia": url_madia,
      "messageId": messageId,
    };
  }
}
