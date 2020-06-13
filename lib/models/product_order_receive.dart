import 'request/pasmand.dart';

class ProductOrderReceive {
  final Pasmand product;
  final String number;
  final String total_price;
  final String price;

  ProductOrderReceive({this.product,this.number, this.total_price,this.price,});

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
      'product' : product,
      'number' : number,
      'total_price' : total_price,
      'price' : price,
    };
  }
}
