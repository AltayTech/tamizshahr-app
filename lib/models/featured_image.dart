import '../models/sizes.dart';

class FeaturedImage {
  final int id;
  final String title;
  final Sizes sizes;

  FeaturedImage({this.id, this.title, this.sizes});

  factory FeaturedImage.fromJson(Map<String, dynamic> parsedJson) {
    return FeaturedImage(
      id: parsedJson['id'],
      title: parsedJson['title'],
      sizes: Sizes.fromJson(parsedJson['sizes']),
    );
  }
}
