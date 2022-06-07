import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/asset/status/auth.dart';
import 'package:we_eat/ui/component/board_component.dart';
import 'package:we_eat/ui/view/chat_room_screen.dart';
import 'package:we_eat/ui/widget/profile_tile_lg_widget.dart';
import 'package:we_eat/ui/widget/profile_tile_md_widget.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';
import 'package:we_eat/view_model/controller/friend_controller.dart';
import 'package:we_eat/view_model/controller/sign_controller.dart';
import 'package:we_eat/view_model/controller/user_controller.dart';
import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SignController _signController = Get.put(SignController());
  final UserController _userController = Get.put(UserController());
  final FriendController _friendController = Get.put(FriendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WE_EAT'),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: () async {
          await _friendController.getFriends();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                ProfileTile_lg(
                  user: AuthController.to.user!,
                  trailing: IconButton(
                    onPressed: () async {
                      await _signController.signOut();
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 30,
                      color: Color(0xFF828282),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                BoardComponent(
                  title: '참여중인 채팅방',
                  paddingL: 0,
                  paddingR: 0,
                  paddingT: 10,
                  backgroundColor: Colors.white,
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //   onPressed: () => Get.to(
                      //     ChatRoomScreen(
                      //       title: '아아아ㅏ',
                      //       uri: Uri.parse('ws://localhost:8080/ws/chat'),
                      //     ),
                      //   ),
                      //   child: Text('채팅방으로'),
                      // ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFDFD),
                          border: Border.all(
                            width: 1,
                            color: Color(0xFFE5E5E5),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              CupertinoIcons.chat_bubble_text_fill,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '치킨 드실 분~',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  CupertinoIcons.location,
                                  size: 16,
                                  color: Color.fromARGB(255, 138, 138, 138),
                                ),
                                Text(
                                  '교촌치킨(역곡2동점)',
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFDFD),
                          border: Border.all(
                            width: 1,
                            color: Color(0xFFE5E5E5),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              CupertinoIcons.chat_bubble_text_fill,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '칼국수를 먹어요',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  CupertinoIcons.location,
                                  size: 16,
                                  color: Color.fromARGB(255, 138, 138, 138),
                                ),
                                Text(
                                  '엄마손칼국시',
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                BoardComponent(
                  title: '친구 목록',
                  paddingL: 0,
                  paddingR: 0,
                  edge: ElevatedButton.icon(
                    onPressed: () => Get.toNamed(Service.ADD_FRIEND_ROUTE),
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: Text(
                      '친구추가',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFE8DEF8),
                      fixedSize: Size(double.infinity, double.infinity),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.sp),
                        ),
                      ),
                    ),
                  ),
                  child: Obx(
                    () {
                      if (_friendController.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _friendController.list.length,
                          itemBuilder: ((context, index) => ProfileTile_md(
                                name: _friendController.list[index].user_name,
                                status:
                                    _friendController.list[index].user_state,
                                onTap: () async {
                                  await _userController.getProfile(
                                      _friendController.list[index]);
                                },
                              )),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
