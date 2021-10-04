import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/repository/product_service_repository.dart';

class ProductServiceController {
  final productServiceData = ProductServiceRepository();

  Future<List<ProductService>> getProductServiceList() {
    List<ProductService> prdtServices = [];

    return productServiceData.getData().then((productServices) {
      productServices.forEach((k, v) {
        prdtServices.add(ProductService.fromMap(v, id: k));
      });
      return prdtServices;
      // return productServiceData.getDataGeneral();
    }).catchError((err) {
      print('ERRO list productservices ${err.msg}');
    });
  }

  Future<List<ProductService>> getDataByCity({required String city}) {
    List<ProductService> prdtServices = [];

    return productServiceData.getDataByCity(city: city).then((productServices) {
      if (productServices != null) {
        productServices.forEach((k, v) {
          prdtServices.add(ProductService.fromMap(v, id: k));
        });
      }
      return prdtServices;
      // return productServiceData.getDataGeneral();
    }).catchError((err) {
      print('ERRO list productservices ${err.msg}');
    });
  }

  Future<List<ProductService>> getStablichmentForCategory(String catId) async {
    List<ProductService> prdtServices = [];

    return productServiceData.getData().then((productServices) {
      productServices.forEach((k, v) {
        var stablichment = ProductService.fromMap(v, id: k);
        var result = stablichment.catIds.contains(catId);
        if (result) {
          prdtServices.add(stablichment);
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
