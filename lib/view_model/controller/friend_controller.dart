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
    UserRepository _userRepository = UserRepository();
    _userRepository
        .getFriends(API.GET_Friends + AuthController.to.user!.user_id)
        .then((result) {
      switch (result) {
        case Result.success:
          break;
        case Result.error:
        default:
          break;
      }
    });
  }
}
