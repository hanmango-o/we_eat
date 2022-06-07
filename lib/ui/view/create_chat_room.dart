import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/user_vo.dart';
import 'package:we_eat/ui/component/board_component.dart';
import 'package:we_eat/ui/widget/profile_tile_md_widget.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';
import 'package:we_eat/view_model/controller/chat_room_controller.dart';
import 'package:we_eat/view_model/controller/friend_controller.dart';
import 'package:we_eat/view_model/controller/restaurant_controller.dart';

class CreateChatRoomScreen extends StatefulWidget {
  const CreateChatRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateChatRoomScreen> createState() => _CreateChatRoomScreenState();
}

class _CreateChatRoomScreenState extends State<CreateChatRoomScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController keyword = TextEditingController();
  final ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  final RestaurantController _restaurantController =
      Get.put(RestaurantController());
  final FriendController _friendController = Get.find<FriendController>();
  int selectedIndex = -1;
  List<int> selectedFriends = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방 생성'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () => Get.back(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '채팅방 이름',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                controller: title,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: '채팅방 이름 입력',
                  hintText: 'ex) 치킨 드실 분~',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 198, 198, 198),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(200),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 198, 198, 198),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(200),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '음식점 선택',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                controller: keyword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: '음식 이름으로 검색',
                  hintText: 'ex) 치킨',
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 198, 198, 198),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(200),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 198, 198, 198),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(200),
                    ),
                  ),
                ),
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();
                  await _restaurantController.getRestaurants(keyword.text);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: Color.fromARGB(255, 198, 198, 198),
                    width: 1.0,
                  ),
                ),
                color: Color.fromARGB(255, 255, 252, 252),
              ),
              height: 250.h,
              child: Obx(
                () {
                  if (_restaurantController.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: _restaurantController.list.length,
                      itemBuilder: ((context, index) => ListTile(
                            onTap: () {
                              setState(() {
                                if (selectedIndex != -1) {
                                  _restaurantController
                                      .list[selectedIndex].selected = false;
                                }
                                _restaurantController.list[index].selected =
                                    true;
                                selectedIndex = index;
                              });
                            },
                            selected:
                                _restaurantController.list[index].selected,
                            selectedColor: Theme.of(context).primaryColor,
                            title: Text(
                              _restaurantController.list[index].place_name,
                            ),
                            subtitle: Text(
                              _restaurantController.list[index].address_name,
                            ),
                            trailing: _restaurantController.list[index].selected
                                ? Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : null,
                          )),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '친구 추가',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'option',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add),
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      await _friendController.getFriends();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        builder: (context) => SizedBox(
                          height: 780.h,
                          child: StatefulBuilder(builder: (context, setState) {
                            selectedFriends = [];
                            return BoardComponent(
                              titlePaddingT: 40.h,
                              titlePaddingL: 15.w,
                              paddingT: 20.h,
                              title: '친구 추가',
                              subTitle: '함께하고 싶은 친구를 선택하세요.',
                              child: Column(
                                children: [
                                  Obx(
                                    () {
                                      if (_friendController.isLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        List<int> selectedList = [];
                                        return SizedBox(
                                          height: 550,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                _friendController.list.length,
                                            itemBuilder: ((context, index) =>
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Checkbox(
                                                      value: _friendController
                                                          .list[index].selected,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _friendController
                                                              .list[index]
                                                              .selected = value;
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 300.w,
                                                      child: ProfileTile_md(
                                                        name: _friendController
                                                            .list[index]
                                                            .user_name,
                                                        status:
                                                            _friendController
                                                                .list[index]
                                                                .user_state,
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  ElevatedButton(
                                    onPressed: () {
                                      List selectedList = [];
                                      for (int i = 0;
                                          i < _friendController.list.length;
                                          i++) {
                                        if (_friendController
                                            .list[i].selected) {
                                          selectedList
                                              .add(_friendController.list[i]);
                                        }
                                      }
                                      log(selectedList.toString());
                                      _friendController.selectedFriends.value =
                                          selectedList;
                                      setState;
                                      Get.back();
                                    },
                                    child: Text('친구 추가'),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Obx(() {
              if (_friendController.selectedFriends.isEmpty) {
                return Container(
                  height: 50.h,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(child: Text('함께할 친구를 선택하세요.')),
                );
              }
              return Column(
                children: _friendController.selectedFriends
                    .map(
                      (e) => ProfileTile_md(
                          name: e.user_name, status: e.user_state),
                    )
                    .toList(),
              );
            }),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text('채팅방 생성'),
                onPressed: () async {
                  if (title.text.isEmpty || selectedIndex == -1) {
                    Get.snackbar('채팅방을 생성할 수 없습니다.', '채팅방 정보를 입력해주세요.');
                  } else {
                    await _chatRoomController.createChatRoom({
                      "chat_name": title.text,
                      "chat_restaurant":
                          _restaurantController.list[selectedIndex].place_name,
                      "user_id": _friendController.selectedFriendsOnlyId()
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
