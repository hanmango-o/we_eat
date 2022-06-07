import 'dart:developer';

import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/user_vo.dart';

class UserRepository extends HttpImpl {
  List<UserVO> list = [];
  late UserVO profile;

  Future<Result> getUsers(String url) async {
    try {
      Uri uri = super.getUri(url);
      List<dynamic> temp = await super.get(uri);
      for (var element in temp) {
        list.add(UserVO.fromMap(element));
      }
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }

  Future<Result> addFriend(Object body) async {
    try {
      Uri uri = super.getUri(API.POST_AddFriend);
      var response = await super.post(uri, body);
      if (response == 0) {
        return Result.error;
      }
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }

  Future<Result> getFriends(String url) async {
    try {
      Uri uri = super.getUri(url);
      List<dynamic> temp = await super.get(uri);
      for (var element in temp) {
        list.add(UserVO.fromMap(element));
      }
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }

  Future<Result> getProfile(String url) async {
    try {
      Uri uri = super.getUri(url);
      var temp = await super.get(uri);
      profile = UserVO.fromMap(temp);
      log(temp.toString());
      log(temp.runtimeType.toString());
    } catch (e) {
      print(e);
      return Result.error;
    }
    return Result.success;
  }
}
