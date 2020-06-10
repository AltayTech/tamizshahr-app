class ColorCodeProductDetail {
  final int id;
  final String title;
  final String colorCode;
  final String price;
  final bool available;

  ColorCodeProductDetail({
    this.id,
    this.title,
    this.colorCode,
    this.price,
    this.available,
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
