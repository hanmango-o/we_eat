import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/user_repository.dart';
import 'package:we_eat/model/vo/user_vo.dart';
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
    String url = API.GET_profile + user.user_id;
    UserRepository _userRepository = UserRepository();
    _userRepository.getProfile(url).then((result) {
      switch (result) {
        case Result.success:
          _profile = _userRepository.profile;
          _isProfileLoading.value = false;
          update();
          break;
        case Result.error:
        default:
          break;
      }
    });
  }
}
