class ColorCode {
  final int id;
  final String title;
  final String color_code;
  final String price;

  ColorCode({
    required this.id,
    required this.title,
    required this.color_code,
    required this.price,
  });

  factory ColorCode.fromJson(Map<String, dynamic> parsedJson) {
    return ColorCode(
      id: parsedJson['id'],
      title: parsedJson['title'],
      color_code: parsedJson['color_code'],
      price: parsedJson['price'],
    );
  }
}
