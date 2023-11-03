class ColorCodeCard {
  final int id;
  final String title;
  final String color_code;

  ColorCodeCard({
    this.id = 0,
    this.title = '',
    this.color_code = '',
  });

  factory ColorCodeCard.fromJson(Map<String, dynamic> parsedJson) {
    return ColorCodeCard(
      id: parsedJson['id'],
      title: parsedJson['title'],
      color_code: parsedJson['color_code'],
    );
  }
}
