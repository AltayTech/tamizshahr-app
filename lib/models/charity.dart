import 'package:flutter/material.dart';
import 'package:tamizshahr/models/charity_data.dart';
import 'package:tamizshahr/models/featured_image.dart';
import 'package:tamizshahr/models/status.dart';

class Charity with ChangeNotifier {
  final int id;
  final Status type;
  final Status status;
  final CharityData charity_data;
  final String summary;
  final String description;
  final FeaturedImage featured_image;
  final List<FeaturedImage> gallery;
  final String money;
  final String sum_of_helps;
  final String sum_of_helps_months;

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
    this.sum_of_helps,
    this.sum_of_helps_months,
  });

  factory Charity.fromJson(Map<String, dynamic> parsedJson) {
    var galleryList = parsedJson['gallery'] as List;
    List<FeaturedImage> galleryRaw =
        galleryList.map((i) => FeaturedImage.fromJson(i)).toList();

    return Charity(
      id: parsedJson['id'],
      type: parsedJson['type'] != null
          ? Status.fromJson(parsedJson['type'])
          : Status(term_id: 0, name: '', slug: ''),
      status: parsedJson['status'] != null
          ? Status.fromJson(parsedJson['status'])
          : Status(term_id: 0, name: '', slug: ''),
      charity_data: CharityData.fromJson(parsedJson['charity_data']),
      summary: parsedJson['summary'] != null ? parsedJson['summary'] : '',
      description:
          parsedJson['description'] != null ? parsedJson['description'] : '',
      featured_image: FeaturedImage.fromJson(parsedJson['featured_image']),
      gallery: galleryRaw,
      money: parsedJson['money'] != null||parsedJson['money'] != '' ? parsedJson['money'] : '0',
      sum_of_helps:
          parsedJson['sum_of_helps'] != null ? parsedJson['sum_of_helps'] : '0',
      sum_of_helps_months: parsedJson['sum_of_helps_months'] != null
          ? parsedJson['sum_of_helps_months']
          : '0',
    );
  }
}
