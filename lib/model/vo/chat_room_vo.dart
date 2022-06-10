// ignore_for_file: non_constant_identifier_names

class ChatRoomVO {
  late int chat_id;
  late String chat_name;
  late String chat_restaurant;
  late int chat_num;
  late String chat_create_time;

  ChatRoomVO({
    required this.chat_id,
    required this.chat_name,
    required this.chat_restaurant,
    required this.chat_num,
    required this.chat_create_time,
  });

  ChatRoomVO.fromMap(Map<String, dynamic> map) {
    chat_id = map['chat_id'];
    chat_name = map['chat_name'];
    chat_restaurant = map['chat_restaurant'];
    chat_num = map['chat_num'];
    chat_create_time = map['chat_create_time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_id': chat_id,
      'chat_name': chat_name,
      'chat_restaurant': chat_restaurant,
      'chat_num': chat_num,
      'chat_create_time': chat_create_time,
    };
  }

  @override
  String toString() {
    return '{chat_id:$chat_id, chat_name:$chat_name, chat_restaurant:$chat_restaurant, chat_num:$chat_num, chat_create_time:$chat_create_time}';
  }
}
