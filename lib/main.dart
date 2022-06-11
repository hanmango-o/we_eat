// Copyright 2022 hanmango-o <hanmango.o@gmail.com> all rights reserved.
// [Author]hanmango-o (https://github.com/hanmango-o)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/font.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/view/add_friend_screen.dart';
import 'package:we_eat/ui/view/chat_list_screen.dart';
import 'package:we_eat/ui/view/create_chat_room.dart';
import 'package:we_eat/ui/view/main_screen.dart';
import 'package:we_eat/ui/view/sign_in_screen.dart';
import 'package:we_eat/ui/view/sign_up_screen.dart';
import 'package:we_eat/splash_screen.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

void main() {
  Get.put(AuthController());
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
          primaryColor: const Color.fromARGB(255, 149, 97, 216),
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
              color: const Color.fromARGB(255, 138, 138, 138),
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
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            selectedItemColor: Color.fromARGB(255, 149, 97, 216),
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
              primary: const Color.fromARGB(255, 149, 97, 216),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.sp),
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 149, 97, 216),
              side: const BorderSide(
                color: Color.fromARGB(255, 149, 97, 216),
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
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 149, 97, 216),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            iconColor: Color.fromARGB(255, 149, 97, 216),
            hintStyle: TextStyle(
              color: Color.fromARGB(255, 157, 158, 160),
            ),
            floatingLabelStyle: TextStyle(
              color: Color.fromARGB(255, 149, 97, 216),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 198, 198, 198),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 198, 198, 198),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 198, 198, 198),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            fillColor: Color.fromARGB(255, 255, 253, 253),
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
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color.fromARGB(255, 149, 97, 216),
          ),
        ),
        initialRoute: Service.SPLASH_ROUTE,
        getPages: [
          GetPage(
            name: Service.SPLASH_ROUTE,
            page: () => const SplashScreen(),
          ),
          GetPage(
            name: Service.MAIN_ROUTE,
            page: () => const MainScreen(),
          ),
          GetPage(
            name: Service.SIGN_UP_ROUTE,
            page: () => const SignUpScreen(),
          ),
          GetPage(
            name: Service.SIGN_IN_ROUTE,
            page: () => const SignInScreen(),
          ),
          GetPage(
            name: Service.CHAT_LIST_ROUTE,
            page: () => const ChatListScreen(),
          ),
          GetPage(
            name: Service.ADD_FRIEND_ROUTE,
            page: () => const AddFriendScreen(),
          ),
          GetPage(
            name: Service.CREATE_CHAT_ROOM_ROUTE,
            page: () => const CreateChatRoomScreen(),
          )
        ],
      ),
    );
  }
}
