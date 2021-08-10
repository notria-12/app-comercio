import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loja_virtual/src/views/Home/home_page.dart';
import 'package:loja_virtual/src/views/HomeAuth/home_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState { empty, loading, authenticated, unauthenticated, error }

class AuthController {
  static AuthController? _instance;
  final navigatorKey = GlobalKey<NavigatorState>();
  final _stateNotifier = ValueNotifier<AuthState>(AuthState.unauthenticated);
  SharedPreferences? _prefs;

  AuthController() {
    listen(() {
      if (AuthController.instance.state == AuthState.unauthenticated) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (_) => HomePage()));
      } else if (AuthController.instance.state == AuthState.authenticated) {
        navigatorKey.currentState!
            .push(MaterialPageRoute(builder: (_) => HomeAuthPage()));
      }
    });
  }

  static AuthController get instance {
    if (_instance == null) {
      _instance = AuthController();
    }
    return _instance!;
  }

  set _state(AuthState state) => _stateNotifier.value = state;
  AuthState get state => _stateNotifier.value;

  void listen(void Function() listener) {
    _stateNotifier.addListener(listener);
  }

  User? user;

  Future<void> init() async {
    _state = AuthState.loading;

    _prefs = await SharedPreferences.getInstance();

    String? userString = _prefs!.getString('user');
    if (userString != null) {
      var userMap = json.decode(userString);
    } else {
      _state = AuthState.unauthenticated;
    }

    //Verificar no shared preferences se existe um usuário logado
    //IF(true) buscar o dado, e insere no _user
    //IF(false) insere _user como nulo
  }

  Future<void> _setUser(User? user) async {
    this.user = user;
    _prefs = await SharedPreferences.getInstance();
    if (this.user == null) {
      _prefs!.remove("user");
    } else {
      _state = AuthState.authenticated;
      var userData = {"email": user!.email, "uid": user.uid};
      _prefs!.setString("user", json.encode(userData));
    }
  }

  void loginUser(User user) {
    _setUser(user);
  }

  void logoutUser() {
    _setUser(null);
  }
}
