import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/repository/product_service_repository.dart';

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
      print('ERRO list productservices ${err.msg}');
    });
  }

  Future<List<ProductService>> getStablichmentForCategory(String catId) async {
    List<ProductService> prdtServices = [];

    return productServiceData.getData().then((productServices) {
      productServices.forEach((k, v) {
        var stablichment = ProductService.fromMap(v);
        var result = stablichment.catIds.contains(catId);
        if (result) {
          prdtServices.add(ProductService.fromMap(v));
        }
      });
      return prdtServices;
    }).catchError((err) {
      print('ERRO');
    });
  }

  Future updateStabblishment(
      String estId, ProductService productService) async {
    await productServiceData.updateData(estId, productService);
  }
}
