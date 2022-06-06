class API {
  static const String _ADDRESS = 'http://localhost:8080/';

  static const String GET_Restaurants = _ADDRESS + 'chat/food?keyword=';
  static const String GET_ChatRooms = _ADDRESS + 'chat/search';
  // 수정해야 함 user_id로
  static const String GET_SignOut = _ADDRESS + 'sign/out?id=';

  static const String POST_CreateChatRoom = _ADDRESS + 'chat/create';
  static const String POST_SignUp = _ADDRESS + 'sign/up';
  static const String POST_SignIn = _ADDRESS + 'sign/in';
}
