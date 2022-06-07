import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/user_repository.dart';
import 'package:we_eat/model/vo/user_vo.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class FriendController extends GetxController {
  final RxList<UserVO> _list = <UserVO>[].obs;
  final RxBool _isLoading = false.obs;

  get list => _list;
  get isLoading => _isLoading.value;

  @override
  void onInit() async {
    super.onInit();
    await getFriends();
  }

  Future addFriend(UserVO target) async {
    UserRepository _userRepository = UserRepository();
    _userRepository.addFriend({
      'user_id': AuthController.to.user!.user_id,
      'target_id': target.user_id,
    }).then((result) {
      switch (result) {
        case Result.success:
          Get.snackbar('친구 추가 완료', '홈화면에서 확인해보세요.');
          break;
        case Result.error:
        default:
          Get.snackbar('친구 추가 실패', '다시 시도해주세요.');
          break;
      }
    });
  }

  Future getFriends() async {
    log('dd');
    _isLoading.value = true;
    _list.clear();
    String url = API.GET_Friends + AuthController.to.user!.user_id;
    UserRepository _userRepository = UserRepository();
    await _userRepository.getFriends(url).then((result) {
      switch (result) {
        case Result.success:
          _list.value = _userRepository.list;
          _isLoading.value = false;
          log(_list.toString());
          update();
          break;
        case Result.error:
        default:
          log('d');
          break;
      }
    });
  }
}
