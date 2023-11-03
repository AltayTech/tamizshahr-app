import 'package:flutter/material.dart';
import 'package:tamizshahr/models/charity_data.dart';
import 'package:tamizshahr/models/featured_image.dart';
import 'package:tamizshahr/models/status.dart';

class Charity with ChangeNotifier {
  final int id;
  final Status type;
  final Status status;
  final List<Status> activities;
  final CharityData charity_data;
  final String summary;
  final String description;
  final FeaturedImage featured_image;
  final List<FeaturedImage> gallery;
  final String money;
  final String sum_of_helps;
  final String sum_of_helps_months;

  Charity({
    required this.id,
    required this.type,
    required this.status,
    required  this.activities,
    required  this.charity_data,
    required  this.summary,
    required  this.description,
    required  this.featured_image,
    required  this.gallery,
    required  this.money,
    required  this.sum_of_helps,
    required  this.sum_of_helps_months,
  });

  factory Charity.fromJson(Map<String, dynamic> parsedJson) {
    var galleryList = parsedJson['gallery'] as List;
    List<FeaturedImage> galleryRaw =
        galleryList.map((i) => FeaturedImage.fromJson(i)).toList();

    List<Status> activitiesRaw = [];
    var activitiesList = parsedJson['activities'] as List;
    activitiesRaw = activitiesList.map((i) => Status.fromJson(i)).toList();

    return Charity(
      id: parsedJson['id'],
      type: parsedJson['type'] != null
          ? Status.fromJson(parsedJson['type'])
          : Status(term_id: 0, name: '', slug: ''),
      status: parsedJson['status'] != null
          ? Status.fromJson(parsedJson['status'])
          : Status(term_id: 0, name: '', slug: ''),
      activities: activitiesRaw,
      charity_data: CharityData.fromJson(parsedJson['charity_data']),
      summary: parsedJson['summary'] != null ? parsedJson['summary'] : '',
      description:
          parsedJson['description'] != null ? parsedJson['description'] : '',
      featured_image: FeaturedImage.fromJson(parsedJson['featured_image']),
      gallery: galleryRaw,
      money: parsedJson['money'] != null || parsedJson['money'] != ''
          ? parsedJson['money']
          : '0',
      sum_of_helps:
          parsedJson['sum_of_helps'] != null ? parsedJson['sum_of_helps'] : '0',
      sum_of_helps_months: parsedJson['sum_of_helps_months'] != null
          ? parsedJson['sum_of_helps_months']
          : '0',
    );
  }
}
