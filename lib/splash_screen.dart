import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_eat/asset/data/service.dart';

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
        Get.offAllNamed(Service.MAIN_ROUTE);
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
              child: Text('Splash'),
            );
          },
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
