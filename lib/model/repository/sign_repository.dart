import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/user_vo.dart';

class SignRepository extends HttpImpl {
  UserVO? user;

  Future<Result> signIn(Object body) async {
    try {
      Uri uri = super.getUri(API.POST_SignIn);
      Map<String, dynamic> temp = await super.post(uri, body);
      if (temp.containsValue(null)) {
        return Result.denied;
      }
      user = UserVO.fromMap(temp);
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }

  Future<Result> signUp(Object body) async {
    try {
      Uri uri = super.getUri(API.POST_SignUp);
      Map<String, dynamic> temp = await super.post(uri, body);
      if (temp.containsValue(null)) {
        return Result.already_exist;
      }
      user = UserVO.fromMap(temp);
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }

  Future<Result> signOut(String url) async {
    try {
      Uri uri = super.getUri(url);
      var result = await super.get(uri);

      if (result == 0) {
        return Result.error;
      }
    } catch (e) {
      return Result.error;
    }
    return Result.success;
  }
}
