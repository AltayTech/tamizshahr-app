import 'package:flutter/foundation.dart';

import '../featured_image.dart';
import '../status.dart';
import 'price_weight.dart';



class WasteCart with ChangeNotifier {
  final int id;
  final String name;
  final String excerpt;
  final List<PriceWeight> prices;
  final Status status;
  final FeaturedImage featured_image;
   int weight;

  WasteCart({
    this.id,
    this.name,
    this.excerpt,
    this.prices,
    this.status,
    this.featured_image,
    this.weight,
  });

  factory WasteCart.fromJson(Map<String, dynamic> parsedJson) {
    var priceWeightList = parsedJson['prices'] as List;
    List<PriceWeight> priceWeightRaw =
        priceWeightList.map((i) => PriceWeight.fromJson(i)).toList();

    return WasteCart(
      id: parsedJson['id'],
      name: parsedJson['name'],
      excerpt: parsedJson['excerpt'],
      prices: priceWeightRaw,
      status: Status.fromJson(parsedJson['Status']),
      featured_image: FeaturedImage.fromJson(parsedJson['featured_image']),
      weight:  parsedJson['weight'],
    );
  }
}
