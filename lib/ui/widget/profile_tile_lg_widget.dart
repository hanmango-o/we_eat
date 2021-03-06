// ignore_for_file: non_constant_identifier_names, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_eat/model/vo/user_vo.dart';

class ProfileTile_lg extends StatelessWidget {
  final UserVO user;
  Color? backgroundColor;
  Color? avatarBackgroundColor;
  Color? avatarForegroundColor;
  double? padding_B;
  Widget? trailing;
  Widget? bottomChild;

  ProfileTile_lg({
    Key? key,
    required this.user,
    this.backgroundColor,
    this.avatarBackgroundColor,
    this.avatarForegroundColor,
    this.trailing,
    this.bottomChild,
    this.padding_B,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFFE8DEF8),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor:
                    avatarBackgroundColor ?? Theme.of(context).primaryColor,
                foregroundColor: avatarForegroundColor ?? Colors.white,
                child: const Icon(
                  Icons.person,
                  size: 45,
                ),
                radius: 30,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.user_name ?? '',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 10),
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
              trailing ?? const SizedBox(),
            ],
          ),
        ),
        SizedBox(height: padding_B ?? 25.h),
        bottomChild ?? const SizedBox(),
      ],
    );
  }
}
