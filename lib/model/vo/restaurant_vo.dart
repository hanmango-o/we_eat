class RestaurantVO {
  late String place_name;
  late String address_name;
  bool selected = false;

  RestaurantVO({
    required this.place_name,
    required this.address_name,
  });

  RestaurantVO.fromMap(Map<String, dynamic> map) {
    place_name = map['place_name'];
    address_name = map['address_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'place_name': place_name,
      'address_name': address_name,
    };
  }

  @override
  String toString() {
    return '{place_name:$place_name, address_name:$address_name, selected:$selected}';
  }
}
