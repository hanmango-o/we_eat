import 'package:get/get.dart';
import 'package:we_eat/asset/status/auth.dart';
import 'package:we_eat/model/vo/user_vo.dart';

/// [AuthController]는 Sign 상태와 처리 결과를 반환하여 전역적으로 [Auth] 상태를 관리합니다.
///
/// [Auth]와 관련된 모든 것을 해당 Controller에서 관리합니다. 이러한 관리를 위해 아래의 기능을 포함하고 있습니다.
///
/// 주요기능:
/// 1. 현재 사용자 상태 저장 : [status]
/// 2. 현재 사용자 정보 저장 : [user]
/// 3. 로그인 성공 이후 사용자 상태 변경 : [signIn]
/// 4. 로그아웃 성공 이후 사용자 상태 변경 : [signOut]
///
/// 각 기능별 사용 조건이 다르기 때문에 주의해야 합니다.
/// 또한, 선행되어야 하는 조건이 만족되지 않을 경우 컴파일 에러가 발생할 수도 있습니다.
/// 선행조건은 각 기능에서 확인할 수 있습니다.
///
/// [AuthController]는 [GetxController]를 상속받습니다.
/// 이에 따라 루트 파일인 `main.dart`에서 아래와 같이 선언됩니다.
///
/// ---
/// Example:
/// ```
/// Get.put(AuthController());
/// ```
///
/// 이후 다른 파일에서 [AuthController]를 사용해야 한다면, 아래와 같이 사용해야 합니다.
/// ```
/// AuthController.to.~
/// ```
///
/// ---
/// See Also:
/// - [Getx] https://pub.dev/documentation/get/latest/
class AuthController extends GetxController {
  /// [status]는 현재 사용자의 상태를 나타냅니다.
  ///
  /// [Auth]에 따라 현재 사용자의 상태를 저장합니다.
  /// 따라서, 사용자의 상태가 변경된다면 [status]를 알맞게 수정해주어야 합니다.
  ///
  /// ---
  /// Example:
  /// ```
  /// AuthController.to.status;
  /// ```
  Auth _status = Auth.signOut;

  get status => _status;

  /// [user]는 현재 사용자 정보를 나타냅니다.
  ///
  /// [UserVO] 객체에 담긴 사용자 정보를 저장 및 관리합니다.
  /// 실질적인 사용자 정보는 [user]에서 불러와 사용하므로,
  /// 사용자의 정보가 변경될 경우 [user]정보 또한 수정되어야 합니다.
  /// ---
  /// Example:
  /// ```
  /// AuthController.to.user!.user_id;
  /// AuthController.to.user!.user_name;
  /// ```
  UserVO? user;

  static AuthController get to => Get.find();

  /// [signIn]은 로그인 성공 이후 사용자 상태와 정보를 변경합니다.
  ///
  /// 사용자 상태[status]를 [Auth.signIn]으로 수정하고 싶을 때 사용합니다.
  /// 또한 사용자 정보 [user]를 Parameter로 받은 `user`로 변경합니다.
  ///
  /// 반드시 현재 사용자 상태가 [Auth.signOut]일때 사용해야 합니다.
  /// ---
  /// Example:
  /// ```
  /// AuthController.to.signIn(user);
  /// ```
  void signIn(UserVO user) {
    this.user = user;
    _status = Auth.signIn;
  }

  /// [signOut]은 로그아웃 성공 이후 사용자 상태와 정보를 변경합니다.
  ///
  /// 사용자 상태[status]를 [Auth.signOut]으로 수정하고 싶을 때 사용합니다.
  /// 또한 사용자 정보 [user]의 값을 해제합니다.
  ///
  /// 반드시 현재 사용자 상태가 [Auth.signIn]일때 사용해야 합니다.
  /// ---
  /// Example:
  /// ```
  /// AuthController.to.signOut();
  /// ```
  void signOut() {
    user = null;
    _status = Auth.signOut;
  }
}
