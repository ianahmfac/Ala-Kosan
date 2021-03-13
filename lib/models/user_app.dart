import 'package:flutter/material.dart';

class UserApp {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  UserApp({
    @required this.id,
    @required this.name,
    @required this.email,
    this.imageUrl,
    @required this.phoneNumber,
  });

  UserApp copyWith({
    String id,
    String name,
    String email,
    String imageUrl,
    String phoneNumber,
  }) {
    return UserApp(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
