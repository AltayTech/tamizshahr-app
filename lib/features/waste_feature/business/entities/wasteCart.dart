import 'package:flutter/foundation.dart';
import 'package:tamizshahr/features/waste_feature/business/entities/price_weight.dart';
import 'package:tamizshahr/models/featured_image.dart';
import 'package:tamizshahr/models/status.dart';


class WasteCart with ChangeNotifier {
  final int id;
  final String name;
  final String excerpt;
  final List<PriceWeight> prices;
  final Status status;
  final FeaturedImage featured_image;
  int weight;

  WasteCart({
    required this.id,
    required this.name,
    required this.excerpt,
    required this.prices,
    required this.status,
    required this.featured_image,
    required this.weight,
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
      weight: parsedJson['weight'],
    );
  }
}
