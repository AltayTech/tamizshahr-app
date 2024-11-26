
import 'package:tamizshahr/features/waste_feature/business/entities/pasmand.dart';

class ProductOrderReceive {
  final Pasmand product;
  final String number;
  final String total_price;
  final String price;

  ProductOrderReceive({
    product,
    this.number = '1',
    this.total_price = '0.0',
    this.price = '0.0',
  }) : this.product = Pasmand(id: 0, post_title: '');

  factory ProductOrderReceive.fromJson(Map<String, dynamic> parsedJson) {
    return ProductOrderReceive(
      product: Pasmand.fromJson(parsedJson['product']),
      number: parsedJson['number'],
      total_price: parsedJson['total_price'],
      price: parsedJson['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'number': number,
      'total_price': total_price,
      'price': price,
    };
  }
}
