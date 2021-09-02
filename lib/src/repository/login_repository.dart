import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/models/user_model.dart';

class LoginRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseDatabase _db = FirebaseDatabase.instance;
  User? user;

  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = response.user;
      return _db
          .reference()
          .child("usuarios")
          .child(user!.uid)
          .get()
          .then((result) async {
        var establishment = await _db
            .reference()
            .child('estabelecimento')
            .child(result!.value['est_id'])
            .get();
        return UserModel(
            email: email,
            establishmentKey: result.value['est_id'],
            productService: ProductService.fromMap(establishment!.value));
      });
      // return UserModel(email: email, establishmentKey: establishmentKey)!;
    } catch (e) {
      print('Error Login $e');
      throw e;
    }
  }

  Future<UserModel> createAcconut(
      {required String email,
      required String password,
      required establishmentKey}) async {
    try {
      return _db
          .reference()
          .child('estabelecimento')
          .child(establishmentKey)
          .once()
          .then((result) async {
        if (result.value != null) {
          final response = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          user = response.user;

          await _db
              .reference()
              .child("usuarios")
              .child(user!.uid)
              .set({"email": user!.email, "est_id": establishmentKey});

          UserModel userModel = UserModel(
              email: email,
              establishmentKey: establishmentKey,
              productService: ProductService.fromMap(result.value));

          return userModel;
        } else {
          throw Exception('Chave inválida');
        }
      }).catchError((error) => throw error);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> hasUsedKey(String establishmentKey) async {
    return await _db
        .reference()
        .child("usuarios")
        .orderByChild('est_id')
        .equalTo(establishmentKey)
        .get()
        .then((snapResult) {
      if (snapResult!.value != null) {
        return true;
      } else {
        return false;
      }
    });
  }
}
