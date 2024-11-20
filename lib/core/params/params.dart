import 'package:flutter/widgets.dart';

class NoParams {}

class TemplateParams {}

class ScanParams {
  final int? id;
  final ImageProvider? image;

  ScanParams({
    required this.id,
    required this.image,
  });
}

class AuthParam {
  final String? situation;

  AuthParam({required this.situation});
}
