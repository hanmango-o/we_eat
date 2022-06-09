import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/asset/status/chat.dart';
import 'package:we_eat/model/vo/chat_room_vo.dart';
import 'package:we_eat/model/vo/chat_vo.dart';
import 'package:we_eat/ui/widget/chat_bubble_widget.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_socket_channel/status.dart' as status;

class ChatRoomScreen extends StatefulWidget {
  final ChatRoomVO? chatRoom;

  ChatRoomScreen({Key? key, required this.chatRoom}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late IOWebSocketChannel channel;
  late FocusNode focusNode;
  List messages = [];
  List<Object> messageList = [];

  TextEditingController _chat = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    channel = IOWebSocketChannel.connect(Uri.parse(API.WS_ChatURL));

    channel.sink.add(jsonEncode({
      "type": ChatType.ENTER.name,
      "chat_id": widget.chatRoom!.chat_id,
      "user_id": AuthController.to.user!.user_id,
      "user_name": AuthController.to.user!.user_name,
      "message": ""
    }));
  }

  @override
  void dispose() {
    super.dispose();
    _chat.clear();
    focusNode.dispose();
    _chat.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.chatRoom!.chat_name,
                style: Theme.of(context).textTheme.headline3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    CupertinoIcons.location_solid,
                    size: 16.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    widget.chatRoom!.chat_restaurant,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () {
              channel.sink.add(jsonEncode({
                "type": ChatType.BACK.name,
                "chat_id": widget.chatRoom!.chat_id,
                "user_id": AuthController.to.user!.user_id,
                "user_name": AuthController.to.user!.user_name,
                "message": "",
              }));
              channel.sink.close();

              Get.offAllNamed(Service.MAIN_ROUTE);
            },
          ),
          actions: [
            TextButton(
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE8DEF8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Text(
                  '채팅방 나가기',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              onPressed: () {
                channel.sink.add(jsonEncode({
                  "type": ChatType.OUT.name,
                  "chat_id": widget.chatRoom!.chat_id,
                  "user_id": AuthController.to.user!.user_id,
                  "user_name": AuthController.to.user!.user_name,
                  "message": ""
                }));
                Get.offAllNamed(Service.MAIN_ROUTE);
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              color: Colors.white,
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  log(snapshot.connectionState.toString());
                  if (snapshot.data != null) {
                    print(snapshot.connectionState.toString());

                    Map<String, dynamic> data =
                        jsonDecode(snapshot.data.toString());
                    messageList.add(ChatVO.fromMap(data));
                    log(messageList.toString());
                  }
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          vertical: 100.sp, horizontal: 15.w),
                      shrinkWrap: true,
                      itemCount: messageList.length,
                      itemBuilder: ((context, index) {
                        return ChatBubble(chat: messageList[index] as ChatVO);
                      }),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10.w, bottom: 20.h, top: 10.h),
                height: 90.h,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        controller: _chat,
                        decoration: InputDecoration(
                          hintText: 'Send Message',
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          fillColor: Color.fromARGB(255, 244, 244, 244),
                          filled: true,
                          focusColor: Color.fromARGB(255, 255, 255, 255),
                          contentPadding: EdgeInsets.only(left: 20, right: 20),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      child: Icon(CupertinoIcons.location_fill),
                      elevation: 0,
                      onPressed: () {
                        if (_chat.text.isNotEmpty) {
                          log(_chat.text);
                          channel.sink.add(jsonEncode({
                            "type": ChatType.TALK.name,
                            "chat_id": widget.chatRoom!.chat_id,
                            "user_id": AuthController.to.user!.user_id,
                            "user_name": AuthController.to.user!.user_name,
                            "message": _chat.text,
                          }));
                        }
                        _chat.text = '';
                      },
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
