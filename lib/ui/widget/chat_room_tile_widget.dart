import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatRoomTileWidget extends StatelessWidget {
  String title;
  String position;
  String createdTime;

  ChatRoomTileWidget({
    Key? key,
    required this.title,
    required this.position,
    required this.createdTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(bottom: 10),
      leading: Icon(
        CupertinoIcons.chat_bubble_fill,
        size: 45.sp,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            CupertinoIcons.location,
            size: 16,
            color: Color.fromARGB(255, 138, 138, 138),
          ),
          Text(
            position,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
      trailing: Text(
        createdTime,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
