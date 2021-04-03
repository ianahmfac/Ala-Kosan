import 'package:flutter/material.dart';

class City {
  final String id;
  final String city;
  final String image;
  final String desc;

  City({
    @required this.id,
    @required this.city,
    @required this.image,
    @required this.desc,
  });

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'],
      city: map['city'],
      image: map['image'],
      desc: map['description'],
    );
  }
}
