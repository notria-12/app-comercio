import 'dart:convert';

import 'package:loja_virtual/src/models/ProductService.dart';

class UserModel {
  String email;
  String establishmentKey;
  ProductService? productService;

  UserModel({
    required this.email,
    required this.establishmentKey,
    this.productService,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'establishmentKey': establishmentKey,
      'productService': productService?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      establishmentKey: map['establishmentKey'],
      productService: ProductService.fromMap(map['productService']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(email: $email, establishmentKey: $establishmentKey, productService: $productService)';
}
