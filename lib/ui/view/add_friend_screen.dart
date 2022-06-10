import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/ui/component/board_component.dart';
import 'package:we_eat/view_model/controller/friend_controller.dart';
import 'package:we_eat/view_model/controller/user_controller.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({Key? key}) : super(key: key);

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  TextEditingController name = TextEditingController();

  final UserController _userController = Get.put(UserController());
  final FriendController _friendController = Get.find<FriendController>();

  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _userController.clearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('친구 추가'),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () async {
            await _friendController.getFriends();
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: BoardComponent(
                title: 'Search',
                subTitle: '이름으로 친구 추가할 사용자를 검색하세요.',
                paddingT: 20,
                paddingR: 0,
                paddingL: 0,
                child: TextFormField(
                  controller: name,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: '이름 입력',
                    hintText: 'ex) 퉁퉁이',
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
                  onEditingComplete: () async {
                    FocusScope.of(context).unfocus();
                    selectedIndex = -1;
                    await _userController.getUsers(name.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            BoardComponent(
              title: '검색 결과',
              paddingR: 0,
              paddingL: 0,
              titlePaddingL: 15.w,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Color.fromARGB(255, 198, 198, 198),
                      width: 1.0,
                    ),
                  ),
                  color: Color.fromARGB(255, 255, 252, 252),
                ),
                height: 400.h,
                child: Obx(
                  () {
                    if (_userController.isUsersLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: _userController.list.length,
                        itemBuilder: ((context, index) => ListTile(
                              leading: Checkbox(
                                value: _userController.list[index].selected,
                                onChanged: (value) {
                                  setState(() {
                                    if (selectedIndex != -1) {
                                      _userController
                                          .list[selectedIndex].selected = false;
                                    }
                                    _userController.list[index].selected =
                                        value;
                                    value!
                                        ? selectedIndex = index
                                        : selectedIndex = -1;

                                    log(selectedIndex.toString());
                                  });
                                },
                              ),
                              selectedColor: Theme.of(context).primaryColor,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 30.sp,
                                    height: 30.sp,
                                    child: CircleAvatar(
                                      child: Icon(
                                        Icons.person,
                                        size: 22.sp,
                                      ),
                                      backgroundColor: const Color(0xFF888888),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Text(
                                    _userController.list[index].user_name,
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _userController.list[index].user_sid,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  Text(
                                    _userController.list[index].user_dept,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            )),
                      );
                    }
                  },
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('친구 추가'),
              onPressed: () async {
                if (selectedIndex == -1) {
                  Get.snackbar('선택된 사용자가 없어요.', '사용자를 선택해주세요.');
                } else {
                  await _friendController.addFriend(
                    _userController.list[selectedIndex].user_id,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
