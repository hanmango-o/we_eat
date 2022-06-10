import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_eat/asset/status/chat.dart';
import 'package:we_eat/model/vo/chat_vo.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class ChatBubble extends StatelessWidget {
  final ChatVO chat;
  final Function()? onTap;

  const ChatBubble({
    Key? key,
    required this.chat,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isOthers = chat.user_id != AuthController.to.user!.user_id;

    if (chat.type == ChatType.ENTER.name || chat.type == ChatType.OUT.name) {
      return Align(
        alignment: Alignment.center,
        child: Text(
            '${chat.user_name} 님이 ${chat.type == ChatType.ENTER.name ? '입장했습니다.' : '나갔습니다.'}'),
      );
    }

    return Align(
      alignment: isOthers ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: isOthers,
                child: Padding(
                  padding: EdgeInsets.only(left: 7.w, bottom: 3.h),
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
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  color: isOthers
                      ? const Color(0xFFE4E4E4)
                      : const Color(0xFFEADFF7),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.sp),
                    topRight: Radius.circular(16.sp),
                    bottomLeft: isOthers ? Radius.zero : Radius.circular(16.sp),
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
      ),
    );
  }
}
