class ColorCodeProductDetail {
  final int id;
  final String title;
  final String colorCode;
  final String price;
  final bool available;

  ColorCodeProductDetail({
    required this.id,
    required this.title,
    required this.colorCode,
    required this.price,
    required this.available,
  });

  factory ColorCodeProductDetail.fromJson(Map<String, dynamic> parsedJson) {
    return ColorCodeProductDetail(
      id: parsedJson['id'],
      title: parsedJson['title'],
      colorCode: parsedJson['color_code'],
      price: parsedJson['price'],
      available: parsedJson['available'],
    );
  }
}
