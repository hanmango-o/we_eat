import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/view/chat_room_screen.dart';
import 'package:we_eat/ui/view/create_chat_room.dart';
import 'package:we_eat/ui/widget/chat_room_tile_widget.dart';
import 'package:we_eat/view_model/controller/chat_room_controller.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatRoomController _chatRoomController = Get.put(ChatRoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chat'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Service.CREATE_CHAT_ROOM_ROUTE),
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          await _chatRoomController.getChatRooms();
        },
        child: Obx(
          () {
            if (_chatRoomController.isGetChatRoomsLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: _chatRoomController.list.length,
                itemBuilder: ((context, index) => ChatRoomTileWidget(
                      title: _chatRoomController.list[index].chat_name,
                      position: _chatRoomController.list[index].chat_restaurant,
                      createdTime:
                          _chatRoomController.list[index].chat_create_time,
                      onTab: () {
                        Get.to(
                          () => ChatRoomScreen(
                            chatRoom: _chatRoomController.list[index],
                          ),
                        );
                      },
                    )),
              );
            }
          },
        ),
      ),
    );
  }
}
