import 'package:firebase_database/firebase_database.dart';
import 'package:loja_virtual/src/models/ProductService.dart';

class ProductServiceRepository {
  final productServiceReference =
      FirebaseDatabase.instance.reference().child('estabelecimento');

  Future getData() async {
    var snap = await productServiceReference.once();
    return snap.value;
  }

  Stream<List<ProductService>> getDataGeneral() async* {
    try {
      yield* productServiceReference.onValue.map((event) =>
          event.snapshot.value.map((e) => ProductService.fromMap(e)));
    } catch (e) {
      throw e;
    }
  }

  Future updateData(
      String stablishmentId, ProductService productService) async {
    await productServiceReference
        .child(stablishmentId)
        .update(productService.toMap());
  }
}
