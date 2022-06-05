import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/sign_repository.dart';
import 'package:we_eat/model/vo/user_vo.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class SignController extends GetxController {
  Future signIn() async {}

  Future signUp(Map<String, dynamic> map) async {
    if (map.containsValue(null) ||
        !map.containsKey('user_id') ||
        !map.containsKey('user_pw') ||
        !map.containsKey('user_name') ||
        !map.containsKey('user_sid') ||
        !map.containsKey('user_dept')) {
      Get.snackbar('알 수 없는 에러', '다시 시도해주세요.');
    } else {
      Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        content: const CircularProgressIndicator.adaptive(
          backgroundColor: Colors.white,
        ),
      );
      SignRepository _signRepository = SignRepository();
      await _signRepository.signUp(map).then((result) {
        switch (result) {
          case Result.success:
            AuthController().to.user = _signRepository.user;
            Get.offAllNamed(Service.MAIN_ROUTE);
            break;
          case Result.already_exist:
            Get.back();
            Get.snackbar('이미 존재하는 계정입니다.', '다시 시도해주세요.');
            break;
          case Result.error:
            Get.back();
            Get.snackbar('알 수 없는 에러', '다시 시도해주세요.');
            break;
        }
      });
    }
  }
}
