class Gallery {
  final int id;
  final String url;

  Gallery({
    required this.id,
    required this.url,
  });

  factory Gallery.fromJson(Map<String, dynamic> parsedJson) {
    return Gallery(
      id: parsedJson['id'],
      url: parsedJson['url'],
    );
  }
}
