class ChatVO {
  late String type;
  late int chat_id;
  late String user_id;
  late String user_name;
  late String message;

  ChatVO({
    required this.type,
    required this.chat_id,
    required this.user_id,
    required this.user_name,
    required this.message,
  });

  ChatVO.fromMap(Map<String, dynamic> map) {
    type = map['type'];
    chat_id = map['chat_id'];
    user_id = map['user_id'];
    user_name = map['user_name'];
    message = map['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'chat_id': chat_id,
      'user_id': user_id,
      'user_name': user_name,
      'message': message,
    };
  }

  @override
  String toString() {
    return '{type:$type, chat_id:$chat_id, user_id:$user_id, user_name,:$user_name, message:$message}';
  }
}
