class UserVO {
  late String user_id;
  late String? user_name;
  late int? user_sid;
  late String? user_dept;

  UserVO({
    required this.user_id,
    this.user_name,
    this.user_sid,
    this.user_dept,
  });

  UserVO.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    user_name = map['user_name'];
    user_sid = map['user_sid'];
    user_dept = map['user_dept'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_name': user_name,
      'user_sid': user_sid,
      'user_dept': user_dept,
    };
  }

  @override
  String toString() {
    return '{user_id:$user_id, user_name:$user_name, user_sid:$user_sid, user_dept:$user_dept}';
  }
}
