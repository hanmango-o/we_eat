import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/ui/component/board_component.dart';
import 'package:we_eat/ui/widget/friend_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                            '김철수',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(height: 10),
                          Text(
                            '201821284',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            '컴퓨터정보공학부',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.offAllNamed(Service.SIGN_IN_ROUTE),
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
                child: Column(
                  children: _friendList
                      .map(
                        (e) => FriendTileWidget(
                          name: e['name'],
                          status: e['status'],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
