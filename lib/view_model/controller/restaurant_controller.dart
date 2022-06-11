import 'package:get/get.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/restaurant_repository.dart';
import 'package:we_eat/model/vo/restaurant_vo.dart';

/// [RestaurantController]는 음식점 검색 과정을 제어합니다.
///
/// 채팅방 생성시 음식점 검색을 통해 역곡 근처 음식점을 찾습니다.
/// [RestaurantRepository]에 음식 키워드를 통해 음식점 정보를 요청합니다.
///
/// 주요기능:
/// 1. 음식점 정보 요청
/// 2. 검색된 음식점 정보 반환
/// 3. 메소드 활성 시작 및 종료 제어
class RestaurantController extends GetxController {
  /// [_list]는 요청된 음식점 정보를 의미합니다.
  ///
  /// [GetxController]의 [obs]를 활용한 [RxList] 타입으로 반응형 변수입니다.
  final RxList<RestaurantVO> _list = <RestaurantVO>[].obs;

  /// [_isLoading]은 현재 로딩 상태를 의미합니다.
  ///
  /// [getRestaurants]에서 Method call의 시작과 종료 시점을 알려주는 역할을 합니다.
  /// [GetxController]를 통해 구현했으며, [obs]변수의 [Future] 사용 시 활용하게 됩니다.
  ///
  /// |[_isLoading]|[getRestaurants]작동 시점                                          |
  /// |:-----------|:---------------------------------------------------------|
  /// |   `true`   |음식점 요청이 완료되어 [_list]에 정상적으로 음식점 정보가 들어온 상태    |
  /// |   `false`  |음식점 요청을 수행하고 있는 상태로, [_list]에 아직 음식점 정보가 없는 상태|
  final RxBool _isLoading = false.obs;

  get list => _list;
  get isLoading => _isLoading.value;

  /// [getRestaurants]는 키워드를 통한 음식점 정보 검색 과정을 제어합니다.
  ///
  /// 음식 정보를 나타내는 [keyword]값을 parameter로 가지며,
  /// 해당 [keyword]를 통해 [API.GET_RESTAURANTS] 요청을 합니다.
  ///
  /// [RestaurantRepository]에 음식점 정보를 요청합니다.
  /// 요청에 성공할 경우[Result.success], [_list]에 요청 결과를 담고 [_isLoading]을 `true`로 변경합니다.
  /// 이후, [update]를 통해 값의 변화를 ui에 알립니다.
  ///
  /// 요청에 실패할 경우[Result.error], 실패 snackbar를 출력합니다.
  Future getRestaurants(String? keyword) async {
    if (keyword != null) {
      _isLoading.value = true;
      _list.clear();
      String url = API.GET_Restaurants + keyword;

      RestaurantRepository _restaurantRepository = RestaurantRepository();
      _restaurantRepository.getRestaurants(url).then((result) {
        switch (result) {
          case Result.success:
            _list.value = _restaurantRepository.list;
            _isLoading.value = false;
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
}
