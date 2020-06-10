import 'package:flutter/material.dart';

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

//  final List<Brand> brand;
//  final List<MetaData> sellcase;
//  final List<ColorCodeProductDetail> color;

  Product({
    this.id,
    this.name,
    this.price,
    this.price_without_discount,
    this.show_in_shop,
    this.excerpt,
    this.description,
    this.category,
    this.featured_image,
    this.gallery,
    this.status,
//    this.brand,
//    this.sellcase,
//    this.color,
  });

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
      excerpt: parsedJson['excerpt']!=null?parsedJson['excerpt']:'',
      description: parsedJson['description'],
      category: Category.fromJson(parsedJson['category']),
      featured_image: FeaturedImage.fromJson(parsedJson['featured_image']),
      gallery: galleryRaw,
      status: Status.fromJson(parsedJson['status']),
    );
  }
}
