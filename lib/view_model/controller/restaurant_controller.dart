import 'dart:developer';

import 'package:get/get.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/restaurant_repository.dart';

class RestaurantController extends GetxController {
  final RxList _list = [].obs;
  final RxBool _isLoading = false.obs;

  get list => _list;
  get isLoading => _isLoading.value;

  Future getRestaurants(String? keyword) async {
    if (keyword != null) {
      _isLoading.value = true;
      _list.clear();
      String url = API.GET_RESTAURANTS + keyword;
      RestaurantRepository _restaurantRepository = RestaurantRepository();
      _restaurantRepository.getRestaurants(url).then((result) {
        switch (result) {
          case Result.success:
            _list.value = _restaurantRepository.list;
            _isLoading.value = false;
            log(_list.toString());
            update();
            break;
          case Result.error:
            Get.snackbar('알 수 없는 에러', '다시 시도해 주세요.');
            break;
        }
      });
    }
  }
}
