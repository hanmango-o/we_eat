class API {
  static const String _PORT = '8080';
  static const String _HOST = 'localhost';
  static const String _HTTP_ADDRESS = 'http://$_HOST:$_PORT/';
  static const String _WS_ADDRESS = 'ws://$_HOST:$_PORT/';

  static const String GET_Restaurants = _HTTP_ADDRESS + 'chat/food?keyword=';
  static const String GET_ChatRooms = _HTTP_ADDRESS + 'chat/search';
  static const String GET_SignOut = _HTTP_ADDRESS + 'sign/out?user_id=';
  static const String GET_SearchUsers =
      _HTTP_ADDRESS + 'user/search?user_name=';
  static const String GET_Friends = _HTTP_ADDRESS + 'user/friend?user_id=';
  static const String GET_Profile = _HTTP_ADDRESS + 'user/profile?user_id=';
  static const String GET_MyChatRooms =
      _HTTP_ADDRESS + 'chat/searchmychatroom?user_id=';

  static const String POST_CreateChatRoom = _HTTP_ADDRESS + 'chat/create';
  static const String POST_SignUp = _HTTP_ADDRESS + 'sign/up';
  static const String POST_SignIn = _HTTP_ADDRESS + 'sign/in';
  static const String POST_AddFriend = _HTTP_ADDRESS + 'user/friend/add';

  static const String WS_ChatURL = _WS_ADDRESS + 'ws/chat';
}
