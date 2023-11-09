class ProductOrderSend {
  final int product;
  final String number;
  final String total_price;
  final String price;

  ProductOrderSend({
    this.product = 1,
    this.number = '',
    this.total_price = '0.0',
    this.price = '0.0',
  });

  factory ProductOrderSend.fromJson(Map<String, dynamic> parsedJson) {
    return ProductOrderSend(
      product: parsedJson['product'],
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
