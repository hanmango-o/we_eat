import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/font.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/view/add_friend_screen.dart';
import 'package:we_eat/ui/view/chat_list_screen.dart';
import 'package:we_eat/ui/view/chat_room_screen.dart';
import 'package:we_eat/ui/view/home_screen.dart';
import 'package:we_eat/ui/view/main_screen.dart';
import 'package:we_eat/ui/view/sign_in_screen.dart';
import 'package:we_eat/ui/view/sign_up_screen.dart';
import 'package:we_eat/splash_screen.dart';

void main() {
  runApp(const WeEat());
}

class WeEat extends StatelessWidget {
  const WeEat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (child) => GetMaterialApp(
        title: 'WE_EAT',
        theme: ThemeData(
          primaryColor: Color(0xFF9561D8),
          fontFamily: Font.SEBANGGothic.name,
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 30.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.SEBANGGothic.name,
              fontWeight: FontWeight.w900,
            ),
            headline2: TextStyle(
              fontSize: 25.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.SEBANGGothic.name,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              fontSize: 20.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.SEBANGGothic.name,
              fontWeight: FontWeight.normal,
            ),
            headline4: TextStyle(
              fontSize: 18.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.SEBANGGothic.name,
              fontWeight: FontWeight.normal,
            ),
            headline5: TextStyle(
              fontSize: 15.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.normal,
            ),
            headline6: TextStyle(
              fontSize: 15.sp,
              color: const Color.fromARGB(255, 145, 145, 145),
              fontWeight: FontWeight.normal,
            ),
          ),
          appBarTheme: AppBarTheme(
            color: const Color.fromARGB(255, 255, 255, 255),
            elevation: 0.0,
            centerTitle: false,
            titleTextStyle: TextStyle(
              fontSize: 22.sp,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontFamily: Font.SEBANGGothic.name,
              fontWeight: FontWeight.w900,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF9561D8),
          ),
        ),
        initialRoute: Service.SPLASH_ROUTE,
        getPages: [
          GetPage(
            name: Service.SPLASH_ROUTE,
            page: () => SplashScreen(),
          ),
          GetPage(
            name: Service.MAIN_ROUTE,
            page: () => MainScreen(),
          ),
          GetPage(
            name: Service.SIGN_UP_ROUTE,
            page: () => SignUpScreen(),
          ),
          GetPage(
            name: Service.SIGN_IN_ROUTE,
            page: () => SignInScreen(),
          ),
          GetPage(
            name: Service.CHAT_LIST_ROUTE,
            page: () => ChatListScreen(),
          ),
          GetPage(
            name: Service.CHAT_ROOM_ROUTE,
            page: () => ChatRoomScreen(),
          ),
          GetPage(
            name: Service.ADD_FRIEND_ROUTE,
            page: () => AddFriendScreen(),
          ),
        ],
      ),
    );
  }
}
