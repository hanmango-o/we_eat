import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardComponent extends StatelessWidget {
  final String title;
  final Widget child;
  final String? subTitle;
  final Widget? edge;
  final Color? backgroundColor;
  final double? paddingT;
  final double? paddingB;
  final double? paddingL;
  final double? paddingR;
  final double? titlePaddingT;
  final double? titlePaddingB;
  final double? titlePaddingL;
  final double? titlePaddingR;
  const BoardComponent({
    Key? key,
    required this.title,
    required this.child,
    this.subTitle,
    this.backgroundColor,
    this.paddingT,
    this.paddingB,
    this.paddingL,
    this.paddingR,
    this.titlePaddingT,
    this.titlePaddingB,
    this.titlePaddingL,
    this.titlePaddingR,
    this.edge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: titlePaddingT ?? 0.w,
              left: titlePaddingL ?? 0.w,
              right: titlePaddingR ?? 0.w,
              bottom: titlePaddingB ?? 0.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    edge ?? const SizedBox(),
                  ],
                ),
                Visibility(
                  visible: subTitle == null ? false : true,
                  child: Text(
                    subTitle ?? '',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.only(
              top: paddingT ?? 0,
              bottom: paddingB ?? 15.w,
              left: paddingL ?? 15.w,
              right: paddingR ?? 15.w,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
