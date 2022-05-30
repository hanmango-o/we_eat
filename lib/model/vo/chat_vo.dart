class ChatVO {
  late String type;
  late String roomId;
  late String sender;
  late String? message;

  ChatVO({
    required this.type,
    required this.roomId,
    required this.sender,
    this.message,
  });

  ChatVO.fromMap(Map<String, dynamic> map) {
    type = map['type'];
    roomId = map['roomId'];
    sender = map['sender'];
    message = map['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'roomId': roomId,
      'sender': sender,
      'message': message ?? '',
    };
  }

  @override
  String toString() {
    return '{type:$type, roomId:$roomId, sender:$sender, message:$message}';
  }
}

/*
channel.sink.add(jsonEncode({
      "type": "ENTER",
      "roomId": "10e07fa1-f72e-45ba-b056-cd5f7e1633fe",
      "sender": "한영찬2",
      "message": ""
    }));
*/