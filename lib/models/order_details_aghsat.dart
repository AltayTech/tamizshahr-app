import 'package:flutter/foundation.dart';

import '../models/gallery.dart';

class OrderDetailsAghsat with ChangeNotifier {
  final String number_pay;
  final String pay;
  final String bank;
  final String owner;
  final String shenaseh;
  final List<Gallery> cheque_images;

  OrderDetailsAghsat({
    this.number_pay,
    this.pay,
    this.bank,
    this.owner,
    this.shenaseh,
    this.cheque_images,
  });

  factory OrderDetailsAghsat.fromJson(Map<String, dynamic> parsedJson) {
    var cheque_imagesList = parsedJson['cheque_images'] as List;
    List<Gallery> cheque_imagesRaw = new List<Gallery>();

    cheque_imagesRaw =
        cheque_imagesList.map((i) => Gallery.fromJson(i)).toList();

    return OrderDetailsAghsat(
      number_pay: parsedJson['number_pay'],
      pay: parsedJson['pay'],
      bank: parsedJson['bank'],
      owner: parsedJson['owner'],
      shenaseh: parsedJson['shenaseh'],
      cheque_images: cheque_imagesRaw,
    );
  }
}
