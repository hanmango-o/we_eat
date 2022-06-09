import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/chat.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';
import 'package:web_socket_channel/io.dart';

class ChatController extends GetxController {
  final RxBool _isLoading = false.obs;
  final int chat_id;
  late IOWebSocketChannel channel;

  get isLoading => _isLoading.value;

  ChatController({required this.chat_id});

  @override
  void onInit() async {
    super.onInit();
    log('dd');
    await enterChat(chat_id);
  }

  Future enterChat(int chat_id) async {
    _isLoading.value = true;
    channel = IOWebSocketChannel.connect(API.WS_ChatURL);
    print(channel);
    channel.sink.add({
      "type": ChatType.ENTER.name,
      "chat_id": 2,
      "user_id": AuthController.to.user!.user_id,
      "user_name": AuthController.to.user!.user_name,
      "message": ""
    });
    print(channel.sink);
    // await Future.delayed(Duration(milliseconds: 500));
    _isLoading.value = false;
  }
}
