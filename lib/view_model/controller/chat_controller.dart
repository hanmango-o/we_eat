// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/chat_repository.dart';
import 'package:we_eat/model/vo/chat_vo.dart';
import 'package:web_socket_channel/io.dart';

class ChatController extends GetxController {
  final RxBool _isLoading = false.obs;
  final List<ChatVO> list = <ChatVO>[].obs;
  late IOWebSocketChannel channel;

  get isLoading => _isLoading.value;

  Future loadData(int chat_id) async {
    _isLoading.value = true;
    ChatRepository _chatRespository = ChatRepository();
    String url = API.GET_LoadData + chat_id.toString();

    _chatRespository.getLoadData(url).then((result) {
      switch (result) {
        case Result.success:
          _isLoading.value = false;
          list.addAll(_chatRespository.list);
          update();
          break;
        case Result.error:
        default:
          break;
      }
    });
  }
}
