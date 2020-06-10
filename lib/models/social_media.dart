class SocialMedia {
  final String telegram;
  final String instagram;

  SocialMedia({this.telegram, this.instagram});

  factory SocialMedia.fromJson(Map<String, dynamic> parsedJson) {
    return SocialMedia(
      telegram: parsedJson['telegram'],
      instagram: parsedJson['instagram'],
    );
  }
}
