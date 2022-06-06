import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/data/service.dart';
import 'package:we_eat/asset/status/auth.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/sign_repository.dart';
import 'package:we_eat/model/vo/user_vo.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class SignController extends GetxController {
  Future signIn(Map<String, dynamic> map) async {
    if (map.containsValue(null) ||
        // key id, pw 는 임시로 해놓은 것, 백엔드 부분이 수정되면 user_id, user_pw로 수정해야 함
        // 관련 부분 모두 수정해야 함(sign in)
        !map.containsKey('user_id') ||
        !map.containsKey('user_pw')) {
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

      _signRepository.signIn(map).then((result) {
        switch (result) {
          case Result.success:
            AuthController.to.signIn(_signRepository.user!);
            log(AuthController.to.user.toString());
            Get.offAllNamed(Service.MAIN_ROUTE);
            break;
          case Result.denied:
            Get.back();
            Get.snackbar('등록되지 않은 회원입니다.', '아이디와 비밀번호를 확인해주세요.');
            break;
          case Result.error:
          default:
            Get.back();
            Get.snackbar('알 수 없는 에러', '다시 시도해주세요.');
            break;
        }
      });
    }
  }

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
            AuthController.to.signIn(_signRepository.user!);
            log(AuthController.to.user.toString());
            Get.offAllNamed(Service.MAIN_ROUTE);
            Get.snackbar('회원가입 성공', '자동 로그인 후 홈화면으로 이동합니다.');
            break;
          case Result.already_exist:
            Get.back();
            Get.snackbar('이미 존재하는 계정입니다.', '다시 시도해주세요.');
            break;
          case Result.error:
          default:
            Get.back();
            Get.snackbar('알 수 없는 에러', '다시 시도해주세요.');
            break;
        }
      });
    }
  }

  Future signOut() async {
    if (AuthController.to.user == null ||
        AuthController.to.status == Auth.signOut) {
      log(AuthController.to.user.toString());
      log(AuthController.to.status.toString());
      Get.snackbar('로그아웃 할 수 없습니다.', '다시 시도해주세요.');
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
      String url = API.GET_SignOut + AuthController.to.user!.user_id;
      _signRepository.signOut(url).then((result) {
        switch (result) {
          case Result.success:
            AuthController.to.signOut();
            Get.offAllNamed(Service.SIGN_IN_ROUTE);
            Get.snackbar('로그아웃 성공', '로그인 화면으로 이동합니다.');
            break;
          case Result.error:
          default:
            Get.snackbar('로그아웃 실패', '다시 시도해주세요.');
            break;
        }
      });
    }
  }
}
