import 'package:flutter/material.dart';
import 'package:tamizshahr/models/sizes.dart';

import 'category.dart';
import 'featured_image.dart';
import 'status.dart';

class Product with ChangeNotifier {
  final int id;
  final String name;
  final String price;
  final String price_without_discount;
  final bool show_in_shop;
  final String excerpt;
  final String description;
  final Category category;
  final FeaturedImage featured_image;
  final List<FeaturedImage> gallery;
  final Status status;

  Product({
    this.id = 0,
    this.name = '',
    this.price = '0.0',
    this.price_without_discount = '0.0',
    this.show_in_shop = true,
    this.excerpt = '',
    this.description = '',
    category,
    featured_image,
    this.gallery = const [],
    status,
  })  : this.status = Status(term_id: 0, name: '', slug: ''),
        this.featured_image = FeaturedImage(sizes: Sizes()),
        this.category = Category(term_id: 0, name: '', slug: '');

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    var galleryList = parsedJson['gallery'] as List;
    List<FeaturedImage> galleryRaw =
        galleryList.map((i) => FeaturedImage.fromJson(i)).toList();

    return Product(
      id: parsedJson['id'],
      name: parsedJson['name'],
      price: parsedJson['price'],
      price_without_discount: parsedJson['price_without_discount'],
      show_in_shop: parsedJson['show_in_shop'],
      excerpt: parsedJson['excerpt'] != null ? parsedJson['excerpt'] : '',
      description: parsedJson['description'],
      category: Category.fromJson(parsedJson['category']),
      featured_image: FeaturedImage.fromJson(parsedJson['featured_image']),
      gallery: galleryRaw,
      status: Status.fromJson(parsedJson['status']),
    );
  }
}
