import 'dart:collection';
import 'dart:developer';

import 'package:we_eat/model/interface/http_Interface.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HttpImpl implements HttpInterface {
  @override
  Uri getUri(String url) => Uri.parse(url);

  @override
  Future post(Uri uri, Object? body) async {
    // log(body.toString());
    var response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode(body),
    );
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = convert.jsonDecode(response.body);
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
        dynamic jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse;
      default:
        throw Exception(response.statusCode);
    }
  }
}
