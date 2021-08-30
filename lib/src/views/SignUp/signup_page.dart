import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Cadastrar',
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
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) {
                              return "A chave é obrigatória!";
                            }
                            if (!input.startsWith('-') && input.length < 10) {
                              return "Informe uma chave válida";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Chave de acesso',
                              labelText: 'Chave de acesso',
                              suffixIcon: Icon(Icons.vpn_key)),
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: validateEmail,
                          decoration: InputDecoration(
                              hintText: 'E-mail',
                              labelText: 'E-mail',
                              suffixIcon: Icon(Icons.email)),
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          validator: (input) {
                            if (input!.isEmpty) {
                              return "A senha não pode ser vazia";
                            }
                            if (input.length < 6) {
                              return "A senha precisa ter pelo menos 6 caracteres";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Senha',
                              labelText: 'Senha',
                              suffixIcon: Icon(Icons.lock)),
                        ),
                        TextFormField(
                          obscureText: true,
                          validator: (input) {
                            if (input != _passwordController.text) {
                              return "As senhas não se coincidem!";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Confirmar senha',
                              labelText: 'Confirmar senha',
                              suffixIcon: Icon(Icons.lock)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                            //   Navigator.of(context).pushReplacement(
                            //       MaterialPageRoute(
                            //           builder: (_) => HomeAuthPage()));
                          },
                          child: Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(top: 30),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              'CADASTRAR',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? email, {bool? result = true}) {
    var emailPatter = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    print("Result $result");
    if (email!.isEmpty) {
      return "Insira um endereço de email";
    } else if (!emailPatter.hasMatch(email)) {
      return "e-mail inválido";
    } else if (!result!) {
      // print(email);
      return "Não existe uma conta com esse email";
    }
  }
}
