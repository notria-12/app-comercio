import 'package:firebase_database/firebase_database.dart';

class ProductServiceRepository {
  final productServiceReference =
      FirebaseDatabase.instance.reference().child('estabelecimento');

  Future getData() async {
    return productServiceReference
        .once()
        .then((snap) => snap.value)
        .catchError((e) => e.message);
  }
}
