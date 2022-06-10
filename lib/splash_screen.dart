import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/asset/image/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future init;

  @override
  void initState() {
    super.initState();
    init = readyForStart();
  }

  Future readyForStart() async {
    Timer(
      const Duration(seconds: 1),
      () async {
        Get.offAllNamed(Service.SIGN_IN_ROUTE);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: init,
          builder: (context, snapshot) {
            return Center(
              child: Stack(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    // alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.splash_image,
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          'We Eat',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomPaint(
                          size: const Size.fromHeight(700),
                          painter: CurvedPainter(
                            color: const Color(0xFFE8DEF8),
                            isBack: true,
                          ),
                        ),
                        CustomPaint(
                          size: const Size.fromHeight(500),
                          painter: CurvedPainter(
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      onWillPop: () async => false,
    );
  }
}

class CurvedPainter extends CustomPainter {
  final Color color;
  final bool? isBack;

  CurvedPainter({required this.color, this.isBack});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;

    var path = Path();

    if (isBack == null) {
      path.moveTo(0, size.height * 0.7);
      path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
          size.width * 0.5, size.height * 0.8);
      path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
          size.width * 1.0, size.height * 0.8);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);

      canvas.drawPath(path, paint);
    } else {
      path.moveTo(0, size.height * 0.76);
      path.quadraticBezierTo(size.width * 0.45, size.height * 0.8,
          size.width * 0.5, size.height * 0.79);
      path.quadraticBezierTo(size.width * 0.6, size.height * 0.8,
          size.width * 1.0, size.height * 0.7);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
