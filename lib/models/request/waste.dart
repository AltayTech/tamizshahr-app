import 'package:flutter/foundation.dart';
import '../featured_image.dart';
import 'price_weight.dart';

import '../status.dart';

class Waste with ChangeNotifier {
  final int id;
  final String name;
  final String excerpt;
  final List<PriceWeight> prices;
  final Status status;
  final FeaturedImage featured_image;

  Waste({
    this.id,
    this.name,
    this.excerpt,
    this.prices,
    this.status,
    this.featured_image,
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
