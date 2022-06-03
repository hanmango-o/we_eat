import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/restaurant_vo.dart';

/// [RestaurantRepository]는 음식점 정보를 요청합니다.
///
/// [HttpImpl]를 사용한 Rest API 통신을 통해 데이터를 요청 및 반환 받습니다.
///
/// 주요 기능:
/// 1. Rest API를 통한 음식점 검색 요청
/// 2. 검색된 음식점 정보 mapping
/// 3. 검색된 음식점 정보 저장
class RestaurantRepository extends HttpImpl {
  /// [list]는 요청한 음식점 정보를 저장합니다.
  ///
  /// [getRestaurants]을 통한 요청이 [Result.success]로 종료되면,
  /// [list]를 호출하여 요청된 음식점 정보를 사용할 수 있습니다.
  List<RestaurantVO> list = [];

  /// [getRestaurants]는 음식점 검색을 요청합니다.
  ///
  /// 음식점 요청 Rest API [url]을 parameter로 가지며,
  /// [HttpImpl]의 [getUri]를 통해 API Call을 시도합니다.
  ///
  /// 반환된 음식점 정보를 [RestaurantVO]에 mapping 시킨 후, [list]에 추가합니다.
  ///
  /// 요청이 성공할 경우, [Result.success]를 반환합니다.
  ///
  /// 요청이 실패할 경우, [Result.error]를 반환합니다.
  Future getRestaurants(String url) async {
    try {
      Uri uri = super.getUri(url);
      List<dynamic> temp = await super.get(uri);
      for (var element in temp) {
        list.add(RestaurantVO.fromMap(element));
      }
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }
}
