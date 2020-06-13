import 'package:flutter/material.dart';
import 'package:tamizshahr/models/belongs.dart';
import 'package:tamizshahr/models/status.dart';

class Transaction with ChangeNotifier {
  final int id;
  final Status transaction_type;
  final Belongs belongs;
  final String money;
  final String operation;

  Transaction({
    this.id,
    this.transaction_type,
    this.belongs,
    this.money,
    this.operation,
  });

  factory Transaction.fromJson(Map<String, dynamic> parsedJson) {
    return Transaction(
      id: parsedJson['id'],
      money: parsedJson['money'],
      operation: parsedJson['operation'],
      transaction_type: parsedJson['transaction_type'] != null
          ? Status.fromJson(parsedJson['transaction_type'])
          : Status(name: '', term_id: 0, slug: ''),
      belongs: parsedJson['belongs'] != null
          ? Belongs.fromJson(parsedJson['belongs'])
          : Belongs(id: 0, name: ''),
    );
  }

  Map<String, dynamic> toJson() {
    Map transaction_type =
        this.transaction_type != null ? this.transaction_type.toJson() : null;
    Map belongs = this.belongs != null ? this.belongs.toJson() : null;

    return {
      'id': id,
      'money': money,
      'operation': operation,
      'transaction_type': transaction_type,
      'belongs': belongs,
    };
  }
}
