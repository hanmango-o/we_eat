// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_eat/asset/status/chat.dart';
import 'package:we_eat/model/vo/chat_vo.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class ChatBubble extends StatelessWidget {
  final ChatVO chat;
  final Function()? onTap;
  final ChatVO? b_chat;

  const ChatBubble({
    Key? key,
    required this.chat,
    this.onTap,
    this.b_chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRelate = false;
    bool isOthers = chat.user_id != AuthController.to.user!.user_id;

    if (chat.type == ChatType.ENTER.name || chat.type == ChatType.OUT.name) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
              '${chat.user_name} 님이 ${chat.type == ChatType.ENTER.name ? '입장했습니다.' : '나갔습니다.'}'),
        ),
      );
    }

    if (chat.type == ChatType.TALK.name &&
        b_chat!.type == ChatType.TALK.name &&
        b_chat != null) {
      if (b_chat!.user_id == chat.user_id && isOthers) {
        isRelate = true;
      }
    }

    return Align(
      alignment: isOthers ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: isOthers && !isRelate,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: InkWell(
                onTap: onTap,
                child: CircleAvatar(
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[600],
                  ),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isOthers && !isRelate,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 3.h),
                      child: Text(
                        chat.user_name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .merge(const TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: isOthers
                          ? const Color(0xFFE4E4E4)
                          : const Color(0xFFEADFF7),
                      borderRadius: BorderRadius.only(
                        topLeft: isOthers
                            ? isRelate
                                ? Radius.circular(16.sp)
                                : Radius.zero
                            : Radius.circular(16.sp),
                        topRight: Radius.circular(16.sp),
                        bottomLeft: Radius.circular(16.sp),
                        bottomRight:
                            isOthers ? Radius.circular(16.sp) : Radius.zero,
                      ),
                    ),
                    child: Text(
                      chat.message,
                      style: Theme.of(context).textTheme.headline5!.merge(
                            TextStyle(
                              color: isOthers
                                  ? Colors.black
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
