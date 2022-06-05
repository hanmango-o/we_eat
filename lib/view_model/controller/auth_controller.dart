import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:we_eat/asset/status/auth.dart';
import 'package:we_eat/model/vo/user_vo.dart';

/// [AuthController]는 Sign 상태와 처리 결과를 반환하여 전역적으로 [Auth] 상태를 관리합니다.
///
/// [Auth]와 관련된 모든 것을 해당 Controller에서 관리합니다. 이러한 관리를 위해 아래의 기능을 포함하고 있습니다.
///
/// 주요기능:
/// 1. 현재 User의 status 관리 및 반환 : [status], [setStatus]
/// 2. 로그인 시도에 대한 처리 요청 후, 처리 결과 제어 : [signIn]
/// 3. 인증 메일 발송 요청 후, 처리 결과 제어 : [sendEmailVerification]
/// 4. 로그아웃 시도에 대한 처리 요청 후, 처리 결과 제어 : [signOut]
/// 5. 회원가입 시도에 대한 처리 요청 후, 처리 결과 제어 : [signUp]
/// 6. 비밀번호 초기화(찾기) 시도에 대한 처리 요청 후, 처리 결과 제어 : [resetPW]
/// 7. 익명 로그인 시도에 대한 처리 요청 후, 처리 결과 제어 : [signInAnonymously]
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
/// final _authController = Get.put(AuthController());
/// ```
///
/// 이후 다른 파일에서 [AuthController]를 사용해야 한다면, 아래와 같이 사용해야 합니다.
///
/// ```
/// final _authController = Get.find<AuthController>();
/// ```
///
/// ---
/// See Also:
/// - [Getx] https://pub.dev/documentation/get/latest/
class AuthController extends GetxController {
  Auth status = Auth.signOut;
  UserVO? user;

  AuthController get to => Get.find();
}
