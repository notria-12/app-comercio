import 'package:flutter/material.dart';
import 'package:loja_virtual/src/views/HomeAuth/home_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                  // Align(
                  //   child: Text(
                  //     'Nome APP',
                  //     style: TextStyle(
                  //         color: Colors.blue,
                  //         fontSize: 32,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  //   alignment: Alignment.topLeft,
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Chave de acesso',
                              labelText: 'Chave de acesso',
                              suffixIcon: Icon(Icons.vpn_key)),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'E-mail',
                              labelText: 'E-mail',
                              suffixIcon: Icon(Icons.email)),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Senha',
                              labelText: 'Senha',
                              suffixIcon: Icon(Icons.lock)),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Confirmar senha',
                              labelText: 'Confirmar senha',
                              suffixIcon: Icon(Icons.lock)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Container(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 2, horizontal: 10),
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(15),
                        //           border: Border.all(color: Colors.blue)),
                        //       child: Text(
                        //         'ESQUECI A SENHA',
                        //         style: TextStyle(
                        //             fontSize: 10,
                        //             fontFamily: 'Roboto',
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => HomeAuthPage()));
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
                  // Container(
                  //     width: double.maxFinite,
                  //     child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             'No possui cadastro? ',
                  //             style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontFamily: 'Roboto',
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //           InkWell(
                  //             onTap: () {},
                  //             child: Text(
                  //               'Cadastrar',
                  //               style: TextStyle(
                  //                   color: Colors.blue,
                  //                   fontSize: 14,
                  //                   fontFamily: 'Roboto',
                  //                   fontWeight: FontWeight.w500),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
