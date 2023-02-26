import 'dart:convert';

class City {
  int? id;
  String? city;

  City({this.city = "City", this.id = null});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    if (id != null) {
      data['id'] = id;
    }
    data['city'] = city;
    return data;
  }

  @override
  toString() {
    return {
      'id': id,
      'city': city,
    }.toString();
  }
}
