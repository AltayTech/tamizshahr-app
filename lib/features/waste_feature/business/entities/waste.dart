import 'package:flutter/foundation.dart';
import 'package:tamizshahr/models/featured_image.dart';
import 'package:tamizshahr/models/status.dart';

import 'price_weight.dart';

class Waste with ChangeNotifier {
  final int id;
  final String name;
  final String excerpt;
  final List<PriceWeight> prices;
  final Status status;
  final FeaturedImage featured_image;

  Waste({
    required this.id,
    required this.name,
    required this.excerpt,
    required this.prices,
    required this.status,
    required this.featured_image,
  });

  factory Waste.fromJson(Map<String, dynamic> parsedJson) {
    var priceWeightList = parsedJson['prices'] as List;
    List<PriceWeight> priceWeightRaw =
        priceWeightList.map((i) => PriceWeight.fromJson(i)).toList();

    return Waste(
      id: parsedJson['id'],
      name: parsedJson['name'],
      excerpt: parsedJson['excerpt'],
      prices: priceWeightRaw,
      status: Status.fromJson(parsedJson['status']),
      featured_image: FeaturedImage.fromJson(parsedJson['featured_image']),
    );
  }
}
