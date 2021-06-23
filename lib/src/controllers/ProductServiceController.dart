import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/repository/ProductServiceRepository.dart';

class ProductServiceController {
  final productServiceData = ProductServiceRepository();

  Future<List<ProductService>> getProductServiceList() async {
    List<ProductService> prdtServices = [];

    return productServiceData.getData().then((productServices) {
      productServices.forEach((k, v) {
        prdtServices.add(ProductService.fromMap(v));
      });
      return prdtServices;
    }).catchError((err) {
      print('ERRO');
    });
  }
}
