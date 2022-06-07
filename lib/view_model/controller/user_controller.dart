import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/data/font.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/user_repository.dart';
import 'package:we_eat/model/vo/user_vo.dart';
import 'package:we_eat/ui/component/board_component.dart';
import 'package:we_eat/ui/widget/profile_tile_lg_widget.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class UserController extends GetxController {
  final RxList<UserVO> _list = <UserVO>[].obs;
  Object _profile = Object().obs;
  final RxBool _isUsersLoading = false.obs;
  final RxBool _isProfileLoading = false.obs;

  get list => _list;
  get profile => _profile;
  get isUsersLoading => _isUsersLoading.value;
  get isProfileLoading => _isProfileLoading.value;

  void clearList() => _list.clear();

  Future getUsers(String? name) async {
    if (name != null) {
      _isUsersLoading.value = true;
      _list.clear();
      String url = API.GET_SearchUsers + name;

      UserRepository _userRepository = UserRepository();
      _userRepository.getUsers(url).then((result) {
        switch (result) {
          case Result.success:
            _list.value = _userRepository.list;
            _list.removeWhere(
              (user) => user.user_id == AuthController.to.user!.user_id,
            );
            _isUsersLoading.value = false;
            update();
            break;
          case Result.error:
          default:
            Get.snackbar('알 수 없는 에러', '다시 시도해 주세요.');
            break;
        }
      });
    }
  }

  Future getProfile(UserVO user) async {
    _isProfileLoading.value = true;
    String url = API.GET_Profile + user.user_id;
    UserRepository _userRepository = UserRepository();
    _userRepository.getProfile(url).then((result) {
      switch (result) {
        case Result.success:
          _profile = _userRepository.profile;
          _isProfileLoading.value = false;
          Get.bottomSheet(
            Container(
              height: 260.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35.sp),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: BoardComponent(
                title: '프로필 확인',
                paddingT: 15.h,
                paddingR: 0,
                paddingL: 0,
                child: ProfileTile_lg(
                  user: _profile as UserVO,
                  backgroundColor: Colors.grey[200],
                  avatarBackgroundColor: Color.fromARGB(255, 170, 170, 170),
                ),
              ),
            ),
          );
          update();
          break;
        case Result.error:
        default:
          break;
      }
    });
  }
}
