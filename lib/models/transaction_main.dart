import 'package:flutter/foundation.dart';
import 'package:tamizshahr/models/search_detail.dart';
import 'package:tamizshahr/models/transaction.dart';

class TransactionMain with ChangeNotifier {
  final SearchDetail searchDetail;

  final List<Transaction> transactions;

  TransactionMain({this.searchDetail, this.transactions});

  factory TransactionMain.fromJson(Map<String, dynamic> parsedJson) {
    var transactionsList = parsedJson['data'] as List;
    List<Transaction> transactionsRaw = new List<Transaction>();

    transactionsRaw =
        transactionsList.map((i) => Transaction.fromJson(i)).toList();

    return TransactionMain(
      searchDetail: SearchDetail.fromJson(parsedJson['details']),
      transactions: transactionsRaw,
    );
  }
}
