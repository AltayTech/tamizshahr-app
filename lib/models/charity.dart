import 'package:flutter/material.dart';
import 'package:tamizshahr/models/charity_data.dart';
import 'package:tamizshahr/models/featured_image.dart';
import 'package:tamizshahr/models/status.dart';

import 'type.dart';

class Charity with ChangeNotifier {
  final int id;
  final TypePost type;
  final Status status;
  final CharityData charity_data;
  final String summary;
  final String description;
  final FeaturedImage featured_image;
  final List<FeaturedImage> gallery;
  final String money;

  Charity({
    this.id,
    this.type,
    this.status,
    this.charity_data,
    this.summary,
    this.description,
    this.featured_image,
    this.gallery,
    this.money,
  });

  factory Charity.fromJson(Map<String, dynamic> parsedJson) {
    var galleryList = parsedJson['gallery'] as List;
    List<FeaturedImage> galleryRaw =
        galleryList.map((i) => FeaturedImage.fromJson(i)).toList();

    return Charity(
      id: parsedJson['id'],
      type: TypePost.fromJson(parsedJson['type']),
      status: Status.fromJson(parsedJson['status']),
      charity_data: CharityData.fromJson(parsedJson['charity_data']),
      summary: parsedJson['summary'] != null ? parsedJson['summary'] : '',
      description:
          parsedJson['description'] != null ? parsedJson['description'] : '',
      featured_image: FeaturedImage.fromJson(parsedJson['featured_image']),
      gallery: galleryRaw,
      money: parsedJson['money'],
    );
  }
}
