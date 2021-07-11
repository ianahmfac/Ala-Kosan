import 'package:flutter/material.dart';

class UserApp {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final int balance;
  final String pin;
  UserApp({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.pin,
    this.imageUrl,
    @required this.phoneNumber,
    this.balance = 0,
  });

  UserApp copyWith({
    String id,
    String name,
    String email,
    String imageUrl,
    String phoneNumber,
    int balance,
  }) {
    return UserApp(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      balance: balance ?? this.balance,
      pin: pin ?? this.pin,
    );
  }
}
