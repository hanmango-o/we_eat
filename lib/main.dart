import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/font.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/view/add_friend_screen.dart';
import 'package:we_eat/ui/view/chat_list_screen.dart';
import 'package:we_eat/ui/view/chat_room_screen.dart';
import 'package:we_eat/ui/view/create_chat_room.dart';
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
      builder: (ctx, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WE_EAT',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
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
              fontWeight: FontWeight.bold,
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
              fontSize: 11.sp,
              color: Color.fromARGB(255, 138, 138, 138),
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
            unselectedItemColor: Color.fromARGB(255, 191, 190, 192),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              fixedSize: Size(320.w, 30.h),
              primary: Color(0xFF9561D8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.sp),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: Color(0xFF9561D8),
              side: BorderSide(
                color: Color(0xFF9561D8),
                width: 1.8,
              ),
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              fixedSize: Size(320.w, 30.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.sp),
                ),
              ),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF9561D8),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            iconColor: Color(0xFF9561D8),
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 157, 158, 160),
            ),
            floatingLabelStyle: TextStyle(
              color: Color(0xFF9561D8),
            ),
            fillColor: Color(0xFFFFFDFD),
            filled: true,
            focusColor: Color.fromARGB(255, 255, 255, 255),
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 198, 198, 198),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 198, 198, 198),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
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
          GetPage(
            name: Service.CREATE_CHAT_ROOM_ROUTE,
            page: () => CreateChatRoomScreen(),
          )
        ],
      ),
    );
  }
}
