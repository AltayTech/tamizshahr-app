class Sizes {
  final String thumbnail;
  final String medium;
  final String large;

  Sizes({
    this.thumbnail = '',
    this.medium = '',
    this.large = '',
  });

  factory Sizes.fromJson(Map<String, dynamic> parsedJson) {
    return Sizes(
      thumbnail: parsedJson['thumbnail'],
      medium: parsedJson['medium'],
      large: parsedJson['large'],
    );
  }
}
