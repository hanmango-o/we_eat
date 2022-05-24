// ignore_for_file: file_names

abstract class HttpInterface {
  Uri getUri(String url);
  Future get(Uri uri);
  Future post(Uri uri, Object? body);
}
