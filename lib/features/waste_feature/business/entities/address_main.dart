import 'package:flutter/material.dart';

import 'address.dart';

class AddressMain with ChangeNotifier {
  final List<Address> addressData;

  AddressMain({
    this.addressData = const [],
  });

  factory AddressMain.fromJson(Map<String, dynamic> parsedJson) {
    var addressList = parsedJson['address_data'] as List;
    List<Address> addressRaw = [];
    addressRaw = addressList.map((i) => Address.fromJson(i)).toList();
    return AddressMain(
      addressData: addressRaw,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map>? addressData = this.addressData != null
        ? this.addressData.map((i) => i.toJson()).toList()
        : null;
    return {
      'address_data': addressData,
    };
  }
}
