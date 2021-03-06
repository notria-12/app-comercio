import 'package:loja_virtual/src/models/user_model.dart';
import 'package:loja_virtual/src/repository/login_repository.dart';

class LoginController {
  LoginRepository loginRepository = LoginRepository();

  Future<UserModel> login(
      {required String email, required String password}) async {
    try {
      UserModel user =
          await loginRepository.login(email: email, password: password);

      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String establishmentKey}) async {
    try {
      UserModel userModel = await loginRepository.createAcconut(
          email: email, password: password, establishmentKey: establishmentKey);
      return userModel;
    } catch (e) {
      throw e;
    }
  }
}
