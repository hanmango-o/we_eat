// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:get/get.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/user_repository.dart';
import 'package:we_eat/model/vo/user_vo.dart';
import 'package:we_eat/view_model/controller/auth_controller.dart';

class FriendController extends GetxController {
  final RxList<UserVO> _list = <UserVO>[].obs;
  final RxBool _isLoading = false.obs;
  RxList selectedFriends = [].obs;

  get list => _list;
  get isLoading => _isLoading.value;
  List<Map> selectedFriendsOnlyId() {
    List<Map> list = [
      {'id': AuthController.to.user!.user_id}
    ];
    for (UserVO element in selectedFriends) {
      list.add({'id': element.user_id});
    }
    log(list.toString());
    return list;
  }

  @override
  void onInit() async {
    super.onInit();
    await getFriends();
  }

  Future addFriend(String user_id) async {
    UserRepository _userRepository = UserRepository();
    _userRepository.addFriend({
      'user_id': AuthController.to.user!.user_id,
      'target_id': user_id,
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
    _isLoading.value = true;
    _list.clear();
    String url = API.GET_Friends + AuthController.to.user!.user_id;
    UserRepository _userRepository = UserRepository();
    await _userRepository.getFriends(url).then((result) {
      switch (result) {
        case Result.success:
          _list.value = _userRepository.list;
          _isLoading.value = false;
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
