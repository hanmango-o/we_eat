import 'package:we_eat/model/interface/http_Interface.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HttpImpl implements HttpInterface {
  @override
  Uri getUri(String url) => Uri.parse(url);

  @override
  Future post(Uri uri, Object? body) async {
    var response = await http.post(uri, body: body);
    // 임시
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      default:
        throw Exception(response.statusCode);
    }
  }

  @override
  Future get(Uri uri) async {
    var response = await http.get(uri);
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      default:
        throw Exception(response.statusCode);
    }
  }
}
