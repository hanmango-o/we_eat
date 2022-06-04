import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/view_model/controller/chat_room_controller.dart';
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

  int selectedIndex = -1;

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
                    onPressed: () => Get.bottomSheet(
                      Container(
                        height: 780.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '친구 추가',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  IconButton(
                                    onPressed: () => Get.back(),
                                    icon: Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      isScrollControlled: true,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50.h,
              width: double.infinity,
              color: Colors.grey[300],
              child: Center(child: Text('함께할 친구를 추가하세요.')),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                child: Text('채팅방 생성'),
                onPressed: () async {
                  await _chatRoomController.createChatRoom({
                    "chat_name": "chatroom2",
                    "chat_restaurant": "chicken",
                    "userIdList": [
                      {"user_id": "minji"},
                      {"user_id": "chulsu"},
                      {"user_id": "gihyun"}
                    ]
                  });
                  // Uri uri =
                  //     HttpImpl().getUri('http://localhost:8080/chat/create');
                  // var temp = await HttpImpl().post(uri, {
                  //   "chat_name": "chatroom2",
                  //   "chat_restaurant": "chicken",
                  //   "userIdList": [
                  //     {"user_id": "minji"},
                  //     {"user_id": "chulsu"},
                  //     {"user_id": "gihyun"}
                  //   ]
                  // });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
