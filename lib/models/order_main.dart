import 'package:flutter/foundation.dart';
import 'package:tamizshahr/models/order.dart';
import 'package:tamizshahr/models/search_detail.dart';

class OrdersMain with ChangeNotifier {
  final SearchDetail searchDetail;

  final List<Order> transactions;

  OrdersMain({required this.searchDetail, required this.transactions});

  factory OrdersMain.fromJson(Map<String, dynamic> parsedJson) {
    var transactionsList = parsedJson['data'] as List;
    List<Order> transactionsRaw = [];

    transactionsRaw = transactionsList.map((i) => Order.fromJson(i)).toList();

    return OrdersMain(
      searchDetail: SearchDetail.fromJson(parsedJson['details']),
      transactions: transactionsRaw,
    );
  }
}
