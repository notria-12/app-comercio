import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/login_controller.dart';
import 'package:loja_virtual/src/models/user_model.dart';
import 'package:loja_virtual/src/views/HomeAuth/home_auth.dart';
import 'package:loja_virtual/src/views/SignUp/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController _textControllerEmail = TextEditingController();
  bool _validate = false;
  String? email = "", password = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Entrar',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    child: Text(
                      'Nome APP',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: !loading,
                          decoration: InputDecoration(
                            hintText: 'E-mail',
                            labelText: 'E-mail',
                            suffixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: _emailValidate,
                          onSaved: (String? val) {
                            email = val;
                          },
                        ),
                        TextFormField(
                          enabled: !loading,
                          decoration: InputDecoration(
                              hintText: 'Senha',
                              labelText: 'Senha',
                              suffixIcon: Icon(Icons.lock)),
                          keyboardType: TextInputType.text,
                          validator: _passValidate,
                          obscureText: true,
                          onSaved: (String? val) {
                            password = val;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.blue)),
                              child: Text(
                                'ESQUECI A SENHA',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        loading
                            ? Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.only(top: 30),
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                              )
                            : InkWell(
                                onTap: _sendForm,
                                child: Container(
                                  width: double.maxFinite,
                                  margin: EdgeInsets.only(top: 30),
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    'ENTRAR',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      width: double.maxFinite,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No possui cadastro? ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () async {
                                var result = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => SignUpPage()));
                                if (result == true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Cadastro realizado com Sucesso!"),
                                  ));
                                }
                              },
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _emailValidate(String? value) {
    var regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (value!.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  String? _passValidate(String? value) {
    if (value!.length < 6) {
      return "Senha mínima de 6 dgitos";
    } else {
      return null;
    }
  }

  _sendForm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LoginController loginController = LoginController();
      loading = true;
      setState(() {});
      try {
        UserModel user =
            await loginController.login(email: email!, password: password!);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => HomeAuthPage(
                  userModel: user,
                )));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao logar, verifique email e senha!')));
      }
      loading = false;
      setState(() {});
    } else {
      // erro de validação
      setState(() {
        _validate = true;
      });
    }
  }
}
