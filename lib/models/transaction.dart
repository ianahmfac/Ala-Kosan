import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String kosanId;
  String kosanName;
  String kosanImageUrl;
  String kosanAddress;
  int month;
  double priceInAMonth;
  double totalPrice;
  String userId;
  DateTime createdAt;
  Transaction({
    @required this.id,
    @required this.kosanId,
    @required this.kosanName,
    @required this.kosanImageUrl,
    @required this.kosanAddress,
    @required this.month,
    @required this.priceInAMonth,
    @required this.totalPrice,
    @required this.userId,
    @required this.createdAt,
  });

  Transaction copyWith({
    String id,
    String kosanId,
    String kosanName,
    String kosanImageUrl,
    String kosanAddress,
    int month,
    double priceInAMonth,
    double totalPrice,
    String userId,
    DateTime createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      kosanId: kosanId ?? this.kosanId,
      kosanName: kosanName ?? this.kosanName,
      kosanImageUrl: kosanImageUrl ?? this.kosanImageUrl,
      kosanAddress: kosanAddress ?? this.kosanAddress,
      month: month ?? this.month,
      priceInAMonth: priceInAMonth ?? this.priceInAMonth,
      totalPrice: totalPrice ?? this.totalPrice,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kosanId': kosanId,
      'kosanName': kosanName,
      'kosanImageUrl': kosanImageUrl,
      'kosanAddress': kosanAddress,
      'month': month,
      'priceInAMonth': priceInAMonth,
      'totalPrice': totalPrice,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      kosanId: map['kosanId'],
      kosanName: map['kosanName'],
      kosanImageUrl: map['kosanImageUrl'],
      kosanAddress: map['kosanAddress'],
      month: map['month'],
      priceInAMonth: map['priceInAMonth'],
      totalPrice: map['totalPrice'],
      userId: map['userId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
