class UserVO {
  late String user_id;
  late String? user_name;
  late int? user_sid;
  late String? user_dept;
  late bool? user_status;

  UserVO({
    required this.user_id,
    this.user_name,
    this.user_sid,
    this.user_dept,
    this.user_status,
  });

  UserVO.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    user_name = map['user_name'];
    user_sid = map['user_sid'];
    user_dept = map['user_dept'];
    user_status = map['user_status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_name': user_name ?? '',
      'user_sid': user_sid ?? -1,
      'user_dept': user_dept ?? '',
      'user_status': user_status ?? false,
    };
  }

  @override
  String toString() {
    return '{user_id:$user_id, user_name:$user_name, user_sid:$user_sid, user_dept:$user_dept}';
  }
}
