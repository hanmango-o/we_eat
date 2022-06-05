class UserVO {
  late String user_id;
  late String? user_name;
  late String? user_sid;
  late String? user_dept;
  late int? user_state;

  UserVO({
    required this.user_id,
    this.user_name,
    this.user_sid,
    this.user_dept,
    this.user_state,
  });

  UserVO.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    user_name = map['user_name'];
    user_sid = map['user_sid'];
    user_dept = map['user_dept'];
    user_state = map['user_state'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_name': user_name ?? '',
      'user_sid': user_sid ?? '',
      'user_dept': user_dept ?? '',
      'user_state': user_state ?? 0,
    };
  }

  @override
  String toString() {
    return '{user_id:$user_id, user_name:$user_name, user_sid:$user_sid, user_dept:$user_dept, user_state:$user_state}';
  }
}
