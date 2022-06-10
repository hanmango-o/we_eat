import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/ui/view/chat_list_screen.dart';
import 'package:we_eat/ui/view/home_screen.dart';
import 'package:we_eat/view_model/controller/chat_room_controller.dart';
import 'package:we_eat/view_model/controller/friend_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  final FriendController _friendController = Get.put(FriendController());

  int _currentIndex = 0;
  final _navScreens = [
    HomeScreen(),
    ChatListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.h),
              child: Icon(Icons.home),
              decoration: BoxDecoration(
                color: _currentIndex == 0 ? Color(0xFFE8DEF8) : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 20.h),
              child: Icon(Icons.chat),
              decoration: BoxDecoration(
                color: _currentIndex == 1 ? Color(0xFFE8DEF8) : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
            label: 'Chat',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (selectedIndex) async {
          setState(() {
            _currentIndex = selectedIndex;
          });
          switch (selectedIndex) {
            case 0:
              await _friendController.getFriends();
              await _chatRoomController.getMyChatRooms();
              break;
            case 1:
              await _chatRoomController.getChatRooms();
              break;
          }
        },
      ),
      body: _navScreens.elementAt(_currentIndex),
    );
  }
}
