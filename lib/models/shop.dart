import 'package:flutter/foundation.dart';
import '../models/social_media.dart';

class Shop with ChangeNotifier {
  final String shop_name;
  final String shop_type;
  final String shop_phone;
  final String shop_cellphone;
  final String support_phone;
  final String shop_slug;
  final String about_shop;
  final String shop_featured_image;
  final List<String> shop_gallery;
  final String logo;
  final String word_hours;
  final String shop_policy;
  final List<String> shop_features;
  final String return_policy;
  final String privacy;
  final String how_to_order;
  final String faq;
  final String pay_methods_desc;
  final String app;
  final String app_cafebazar;
  final String address;
  final SocialMedia social_media;

  Shop(
      {this.shop_name,
      this.shop_type,
      this.shop_phone,
      this.shop_cellphone,
      this.support_phone,
      this.shop_slug,
      this.about_shop,
      this.shop_featured_image,
      this.shop_gallery,
      this.logo,
      this.word_hours,
      this.shop_policy,
      this.shop_features,
      this.return_policy,
      this.privacy,
      this.how_to_order,
      this.faq,
      this.pay_methods_desc,
      this.app,
      this.app_cafebazar,
      this.address,
      this.social_media});

  factory Shop.fromJson(Map<String, dynamic> parsedJson) {
    var shop_galleryList = parsedJson['shop_gallery'] as List;
    List<String> shop_galleryRaw =
        shop_galleryList.map((i) => i.toString()).toList();

    var shopfeatursList = parsedJson['shop_features'] as List;
    List<String> shopfeatursRaw =
        shopfeatursList.map((i) => i.toString()).toList();

    return Shop(
      shop_name: parsedJson['shop_name'],
      shop_type: parsedJson['shop_type'],
      shop_phone: parsedJson['shop_phone'],
      shop_cellphone: parsedJson['shop_cellphone'],
      support_phone: parsedJson['support_phone'],
      shop_slug: parsedJson['shop_slug'],
      about_shop: parsedJson['about_shop'],
      shop_featured_image: parsedJson['shop_featured_image'],
      shop_gallery: shop_galleryRaw,
      logo: parsedJson['logo'],
      word_hours: parsedJson['word_hours'],
      shop_policy: parsedJson['shop_policy'],
      shop_features: shopfeatursRaw,
      return_policy: parsedJson['return_policy'],
      privacy: parsedJson['privacy'],
      how_to_order: parsedJson['how_to_order'],
      faq: parsedJson['faq'],
      pay_methods_desc: parsedJson['pay_methods_desc'],
      app: parsedJson['app'],
      address: parsedJson['address'],
      social_media: SocialMedia.fromJson(parsedJson['social_media']),
    );
  }
}
