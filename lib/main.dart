import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/view/add_friend_screen.dart';
import 'package:we_eat/ui/view/chat_list_screen.dart';
import 'package:we_eat/ui/view/chat_room_screen.dart';
import 'package:we_eat/ui/view/home_screen.dart';
import 'package:we_eat/ui/view/sign_in_screen.dart';
import 'package:we_eat/ui/view/sign_up_screen.dart';
import 'package:we_eat/ui/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: Service.SPLASH_ROUTE, page: () => SplashScreen()),
        GetPage(name: Service.HOME_ROUTE, page: () => HomeScreen()),
        GetPage(name: Service.SIGN_UP_ROUTE, page: () => SignUpScreen()),
        GetPage(name: Service.SIGN_IN_ROUTE, page: () => SignInScreen()),
        GetPage(name: Service.CHAT_LIST_ROUTE, page: () => ChatListScreen()),
        GetPage(name: Service.CHAT_ROOM_ROUTE, page: () => ChatRoomScreen()),
        GetPage(name: Service.ADD_FRIEND_ROUTE, page: () => AddFriendScreen()),
      ],
      initialRoute: Service.SPLASH_ROUTE,
    );
  }
}
