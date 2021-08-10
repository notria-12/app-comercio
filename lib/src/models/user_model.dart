import 'package:loja_virtual/src/models/ProductService.dart';

class UserModel {
  String email;
  String establishmentKey;
  ProductService? productService;

  UserModel(
      {required this.email,
      required this.establishmentKey,
      required productService});
}
