import 'dart:developer';

import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/chat_room_vo.dart';
import 'package:we_eat/model/vo/restaurant_vo.dart';

class ChatRoomRepository extends HttpImpl {
  List<ChatRoomVO> list = [];
  ChatRoomVO? chatRoom;

  Future<Result> getChatRooms() async {
    try {
      Uri uri = super.getUri(API.GET_ChatRooms);
      List<dynamic> temp = await super.get(uri);

      for (var element in temp) {
        list.add(ChatRoomVO.fromMap(element));
      }
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }

  Future<Result> createChatRoom(Object body) async {
    try {
      Uri uri = super.getUri(API.POST_CreateChatRoom);
      var map = await super.post(uri, body);
      chatRoom = ChatRoomVO.fromMap(map);
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }
}
