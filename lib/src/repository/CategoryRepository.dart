import 'package:firebase_database/firebase_database.dart';

class CategoryRepository {
  final categoryRefence =
      FirebaseDatabase.instance.reference().child('categorias');

  Future getData() async {
    return categoryRefence
        .once()
        .then((snap) => snap.value)
        .catchError((e) => e.message);
  }
}
