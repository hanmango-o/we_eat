// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/chat_room_vo.dart';

class ChatRoomRepository extends HttpImpl {
  List<ChatRoomVO> list = [];
  List<ChatRoomVO> m_list = [];
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

  Future<Result> getMyChatRooms(String url) async {
    try {
      Uri uri = super.getUri(url);
      List<dynamic> temp = await super.get(uri);

      for (var element in temp) {
        m_list.add(ChatRoomVO.fromMap(element));
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
      print(e);
      return Result.error;
    }
    return Result.success;
  }
}
