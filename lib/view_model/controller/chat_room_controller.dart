import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/chat_room_repository.dart';
import 'package:we_eat/model/vo/chat_room_vo.dart';
import 'package:we_eat/ui/view/chat_room_screen.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class ChatRoomController extends GetxController {
  String? _chatName;
  String? _chatRestaurant;
  List<Map> _chatIdList = [
    {"user_id": 'AuthController.info.user_id'},
  ];
  final RxList<ChatRoomVO> _list = <ChatRoomVO>[].obs;
  final RxList<ChatRoomVO> _m_list = <ChatRoomVO>[].obs;

  /// [_isLoading]은 현재 로딩 상태를 의미합니다.
  ///
  /// [getRestaurants]에서 Method call의 시작과 종료 시점을 알려주는 역할을 합니다.
  /// [GetxController]를 통해 구현했으며, [obs]변수의 [Future] 사용 시 활용하게 됩니다.
  ///
  /// |[_isLoading]|[signOut]작동 시점                                          |
  /// |:-----------|:---------------------------------------------------------|
  /// |   `true`   |전체 채팅방 목록 리스트 요청이 완료되어 [_list]에 정상적으로 채팅방 정보가 들어온 상태    |
  /// |   `false`  |전체 채팅방 목록 리스트 요청을 수행하고 있는 상태로, [_list]에 아직 채팅방 정보가 없는 상태|
  final RxBool _isGetChatRoomsLoading = false.obs;
  final RxBool _isGetMyChatRoomsLoading = false.obs;

  get list => _list;
  get m_list => _m_list;

  get isGetChatRoomsLoading => _isGetChatRoomsLoading.value;
  get isGetMyChatRoomsLoading => _isGetMyChatRoomsLoading.value;

  @override
  void onInit() async {
    super.onInit();
    await getMyChatRooms();
    await getChatRooms();
  }

  Future getChatRooms() async {
    _isGetChatRoomsLoading.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    ChatRoomRepository _chatRoomRepository = ChatRoomRepository();

    _chatRoomRepository.getChatRooms().then((result) {
      switch (result) {
        case Result.success:
          _list.value = _chatRoomRepository.list;
          _isGetChatRoomsLoading.value = false;
          update();
          break;
        case Result.error:
        default:
          Get.snackbar('채팅방 불러오기 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  Future createChatRoom(Object body) async {
    ChatRoomRepository _chatRoomRepository = ChatRoomRepository();

    _chatRoomRepository.createChatRoom(body).then((result) {
      switch (result) {
        case Result.success:
          log(_chatRoomRepository.chatRoom.toString());
          Get.to(
            () => ChatRoomScreen(chatRoom: _chatRoomRepository.chatRoom),
          );
          break;
        case Result.error:
        default:
          Get.snackbar('채팅방 생성 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  Future getMyChatRooms() async {
    _isGetMyChatRoomsLoading.value = true;
    String url = API.GET_MyChatRooms + AuthController.to.user!.user_id;
    ChatRoomRepository _chatRoomRepository = ChatRoomRepository();

    _chatRoomRepository.getMyChatRooms(url).then((result) {
      switch (result) {
        case Result.success:
          _m_list.value = _chatRoomRepository.m_list;
          _isGetMyChatRoomsLoading.value = false;
          update();
          break;
        case Result.error:
        default:
          Get.snackbar('채팅방 불러오기 실패', '다시 시도해주세요.');
          break;
      }
    });
  }
}
