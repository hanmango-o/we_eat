import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/restaurant_vo.dart';

class RestaurantRepository extends HttpImpl {
  List<RestaurantVO> list = [];

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
