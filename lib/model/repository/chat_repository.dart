import 'dart:developer';

import 'package:we_eat/asset/status/result.dart';
import 'package:we_eat/model/repository/impl/http_impl.dart';
import 'package:we_eat/model/vo/chat_vo.dart';

class ChatRepository extends HttpImpl {
  List<ChatVO> list = [];

  Future<Result> getLoadData(String url) async {
    log('message');
    try {
      Uri uri = super.getUri(url);
      List<dynamic> temp = await super.get(uri);

      for (var element in temp) {
        list.add(ChatVO.fromMap(element));
      }
    } catch (e) {
      log(e.toString());
      return Result.error;
    }
    return Result.success;
  }
}
