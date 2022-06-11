// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';
import 'package:we_eat/asset/data/api.dart';
import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/chat_repository.dart';
import 'package:we_eat/model/vo/chat_vo.dart';

/// [ChatController]는 채팅 과정을 제어합니다.
///
/// 웹소켓을 활용한 채팅 시 필요한 데이터 요청 및 웹소켓을 생성합니다.
/// [ChatRepository]에 이전 채팅 데이터를 요청합니다.
///
/// 주요기능:
/// 1. 채팅 데이터 저장 및 관리
/// 2. 이전 채팅 데이터 요청
class ChatController extends GetxController {
  /// [_isLoading]은 현재 로딩 상태를 의미합니다.
  ///
  /// [loadData]에서 Method call의 시작과 종료 시점을 알려주는 역할을 합니다.
  /// [GetxController]를 통해 구현했으며, [obs]변수의 [Future] 사용 시 활용하게 됩니다.
  ///
  /// |[_isLoading]|[loadData]작동 시점                                          |
  /// |:-----------|:---------------------------------------------------------|
  /// |   `true`   |이전 대화 내용 요청이 완료되어 [list]에 정상적으로 데이터가 들어온 상태    |
  /// |   `false`  |대화 내용 요청을 수행하고 있는 상태로, [list]에 아직 데이터가 없는 상태|
  final RxBool _isLoading = false.obs;

  /// [list]는 채팅을 저장하고 반환합니다.
  ///
  /// [loadData]에 의해 요청된 이전 채팅 내용 데이터 뿐만 아니라,
  /// 현재 연결된 소켓에서의 새로운 채팅 내용까지 함께 저장합니다.
  final List<ChatVO> list = <ChatVO>[].obs;

  get isLoading => _isLoading.value;

  /// [loadData]는 이전 채팅 내용을 요청하고 처리합니다.
  ///
  /// 사용자가 채팅방에 접근할 시 작동됩니다.
  /// [ChatRepository]에 이전 채팅 내용을 요청합니다.
  /// 요청에 성공할 경우, [list]에 채팅 내용을 추가하고 [update]합니다.
  Future loadData(int chat_id) async {
    _isLoading.value = true;
    ChatRepository _chatRespository = ChatRepository();
    String url = API.GET_LoadData + chat_id.toString();

    _chatRespository.getLoadData(url).then((result) {
      switch (result) {
        case Result.success:
          _isLoading.value = false;
          list.addAll(_chatRespository.list);
          update();
          break;
        case Result.error:
        default:
          break;
      }
    });
  }
}
