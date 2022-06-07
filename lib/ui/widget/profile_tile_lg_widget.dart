import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_eat/model/vo/user_vo.dart';

class ProfileTile_lg extends StatelessWidget {
  final UserVO user;
  Color? backgroundColor;
  Color? avatarBackgroundColor;
  Color? avatarForegroundColor;
  Widget? trailing;

  ProfileTile_lg({
    Key? key,
    required this.user,
    this.backgroundColor,
    this.avatarBackgroundColor,
    this.avatarForegroundColor,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(0xFFE8DEF8),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor:
                avatarBackgroundColor ?? Theme.of(context).primaryColor,
            foregroundColor: avatarForegroundColor ?? Colors.white,
            child: Icon(
              Icons.person,
              size: 45,
            ),
            radius: 30,
          ),
          SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.user_name ?? '',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 10),
                Text(
                  user.user_dept ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  user.user_sid ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          trailing ?? SizedBox(),
        ],
      ),
    );
  }
}
