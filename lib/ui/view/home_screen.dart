import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/component/board_component.dart';
import 'package:we_eat/ui/view/chat_room_screen.dart';
import 'package:we_eat/ui/widget/friend_tile_widget.dart';
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
  // final UserController _userController = UserController();
  final FriendController _friendController = Get.put(FriendController());

  List<Map<String, dynamic>> _friendList = [
    {'name': '영희', 'status': true},
    {'name': '바둑이', 'status': true},
    {'name': '고릴라', 'status': false},
    {'name': '퉁퉁이', 'status': false},
    {'name': '스티븐', 'status': true},
    {'name': '팀쿡', 'status': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WE_EAT'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE8DEF8),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.white,
                      ),
                      radius: 30,
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AuthController.to.user!.user_name ?? '',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(height: 10),
                          Text(
                            AuthController.to.user!.user_sid ?? '',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            AuthController.to.user!.user_dept ?? '',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _signController.signOut();
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 30,
                        color: Color(0xFF828282),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              BoardComponent(
                title: '참여중인 채팅방',
                paddingL: 0,
                paddingR: 0,
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.to(
                        ChatRoomScreen(
                          title: '아아아ㅏ',
                          uri: Uri.parse('ws://localhost:8080/ws/chat'),
                        ),
                      ),
                      child: Text('채팅방으로'),
                    ),
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
              ElevatedButton(
                onPressed: () async {
                  await _friendController.getFriends();
                },
                child: Text('dd'),
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
                    if (!_friendController.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      log(_friendController.list.toString());
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _friendController.list.length,
                        itemBuilder: ((context, index) => FriendTileWidget(
                              name: _friendController.list[index].user_name,
                              status: _friendController.list[index].user_state,
                            )),
                      );
                    }
                  },
                ),
                // child: Obx(() {
                //   if (_friendController.isLoading) {
                //     return Center(child: CircularProgressIndicator());
                //   } else {
                //     return Column(
                //       children: _friendController.list
                //           .map(
                //             (e) => FriendTileWidget(
                //               name: e.user_name,
                //               status: e.user_state,
                //             ),
                //           )
                //           .toList(),
                //     );
                //   }
                // }),

                // child: Column(
                //   children: Obx(
                //     () {
                //       if (_userController.isLoading) {
                //         return Center(child: CircularProgressIndicator());
                //       } else {
                //         return [];
                //         // return ListView.builder(
                //         //   itemCount: _userController.list.length,
                //         //   itemBuilder: ((context, index) => ListTile(
                //         //         onTap: () {
                //         //           setState(() {
                //         //             if (selectedIndex != -1) {
                //         //               _restaurantController
                //         //                   .list[selectedIndex].selected = false;
                //         //             }
                //         //             _restaurantController.list[index].selected =
                //         //                 true;
                //         //             selectedIndex = index;
                //         //           });
                //         //         },
                //         //         selected:
                //         //             _restaurantController.list[index].selected,
                //         //         selectedColor: Theme.of(context).primaryColor,
                //         //         title: Text(
                //         //           _restaurantController.list[index].place_name,
                //         //         ),
                //         //         subtitle: Text(
                //         //           _restaurantController
                //         //               .list[index].address_name,
                //         //         ),
                //         //         trailing: _restaurantController
                //         //                 .list[index].selected
                //         //             ? Icon(
                //         //                 Icons.check,
                //         //                 color: Theme.of(context).primaryColor,
                //         //               )
                //         //             : null,
                //         //       )),
                //         // );
                //       }
                //     },
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
