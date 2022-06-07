class API {
  static const String _ADDRESS = 'http://localhost:8080/';

  static const String GET_Restaurants = _ADDRESS + 'chat/food?keyword=';
  static const String GET_ChatRooms = _ADDRESS + 'chat/search';
  static const String GET_SignOut = _ADDRESS + 'sign/out?user_id=';
  static const String GET_SearchUsers = _ADDRESS + 'user/search?user_name=';
  static const String GET_Friends = _ADDRESS + 'user/friend?user_id=';
  static const String GET_Profile = _ADDRESS + 'user/profile?user_id=';
  static const String GET_MyChatRooms =
      _ADDRESS + 'chat/searchmychatroom?user_id=';

  static const String POST_CreateChatRoom = _ADDRESS + 'chat/create';
  static const String POST_SignUp = _ADDRESS + 'sign/up';
  static const String POST_SignIn = _ADDRESS + 'sign/in';
  static const String POST_AddFriend = _ADDRESS + 'user/friend/add';
}
