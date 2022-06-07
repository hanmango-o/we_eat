import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendTileWidget extends StatelessWidget {
  String name;
  int status;
  Function()? onTap;
  FriendTileWidget({
    Key? key,
    required this.name,
    required this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      contentPadding: EdgeInsets.only(bottom: 10),
      leading: CircleAvatar(
        backgroundColor: Colors.grey[400],
        child: Icon(
          Icons.person,
          size: 30.sp,
          color: Colors.white,
        ),
        radius: 20,
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.headline5,
      ),
      trailing: FittedBox(
        child: Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 10.sp,
                height: 10.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: status == 1
                      ? Theme.of(context).primaryColor
                      : Color.fromARGB(255, 138, 138, 138),
                ),
              ),
              SizedBox(width: 6),
              Text(
                status == 1 ? '사용중' : '자리비움',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: status == 1
                      ? Theme.of(context).primaryColor
                      : Color.fromARGB(255, 138, 138, 138),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
