import 'package:flutter/material.dart';
import 'package:tamizshahr/models/request/pasmand.dart';

class Transaction with ChangeNotifier {
  final int id;
  final String money;
  final Pasmand user;

  Transaction({
    this.id,
    this.money,
    this.user,
  });

  factory Transaction.fromJson(Map<String, dynamic> parsedJson) {
    return Transaction(
      id: parsedJson['id'],
      money: parsedJson['money'],
      user: parsedJson['user'] != null
          ? Pasmand.fromJson(parsedJson['user'])
          : Pasmand(id: 0, post_title: ''),
    );
  }

  Map<String, dynamic> toJson() {
    Map user = this.user != null ? this.user.toJson() : null;

    return {
      'id': id,
      'money': money,
      'user': user,
    };
  }
}
