import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/view/create_chat_room.dart';
import 'package:we_eat/ui/widget/chat_room_tile_widget.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<Map<String, dynamic>> _chatList = [
    {
      'title': '치킨 드실 분~',
      'position': '교촌치킨(역곡2호점)',
      'ws': 'ws://dfdfdfd:8080',
      'createdTime': 'today 6PM'
    },
    {
      'title': '치킨 드실 분~',
      'position': '교촌치킨(역곡2호점)',
      'ws': 'ws://dfdfdfd:8080',
      'createdTime': 'today 6PM'
    },
    {
      'title': '치킨 드실 분~',
      'position': '교촌치킨(역곡2호점)',
      'ws': 'ws://dfdfdfd:8080',
      'createdTime': 'today 6PM'
    },
    {
      'title': '치킨 드실 분~',
      'position': '교촌치킨(역곡2호점)',
      'ws': 'ws://dfdfdfd:8080',
      'createdTime': 'today 6PM'
    },
    {
      'title': '치킨 드실 분~',
      'position': '교촌치킨(역곡2호점)',
      'ws': 'ws://dfdfdfd:8080',
      'createdTime': 'today 6PM'
    },
    {
      'title': '치킨 드실 분~',
      'position': '교촌치킨(역곡2호점)',
      'ws': 'ws://dfdfdfd:8080',
      'createdTime': 'today 6PM'
    },
    {
      'title': '치킨 드실 분~',
      'position': '교촌치킨(역곡2호점)',
      'ws': 'ws://dfdfdfd:8080',
      'createdTime': 'today 6PM'
    },
  ];

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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _chatList.length,
        itemBuilder: (context, index) => ChatRoomTileWidget(
          title: _chatList[index]['title'],
          position: _chatList[index]['position'],
          createdTime: _chatList[index]['createdTime'],
        ),
      ),
    );
  }
}
