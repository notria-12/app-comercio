import 'package:firebase_database/firebase_database.dart';

class ProductServiceRepository {
  final productServiceReference =
      FirebaseDatabase.instance.reference().child('estabelecimento');

  Future getData() async {
    var snap = await productServiceReference.once();
    return snap.value;
  }
}
