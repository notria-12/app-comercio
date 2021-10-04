import 'package:firebase_database/firebase_database.dart';
import 'package:loja_virtual/src/models/city_model.dart';

class CityRepository {
  final cityReference = FirebaseDatabase.instance.reference().child('cidades');

  Future getCities() async {
    try {
      var snap = await cityReference.once();
      return snap.value;
    } catch (e) {
      throw e;
    }
  }
}
