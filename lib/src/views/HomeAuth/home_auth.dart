import 'package:flutter/material.dart';
import 'package:loja_virtual/src/models/user_model.dart';
import 'package:loja_virtual/src/shared/widgets/drawer_auth_widget.dart';

class HomeAuthPage extends StatelessWidget {
  const HomeAuthPage({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Tem certeza?'),
                content: new Text('Realmente deseja sair da área de acesso?'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("NÃO"),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Text("SIM"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Início'),
        ),
        drawer: DrawerAuthWidget(
          userEmail: userModel.email,
          urlImage: userModel.productService!.imagePath,
          establishmentName: userModel.productService!.name,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá,\nSeja bem vindo!',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Meu estabelecimento:',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    borderRadius: BorderRadius.circular(4),
                    elevation: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 244,
                            width: 244,
                            child: Image.asset(
                              'assets/img/eletro-fase.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 244,
                            child: Text(
                              "Eletro Fase",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(117, 117, 117, 1)),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: 244,
                            child: Text(
                              "Alamenda Demétrioo Cavlak, 2094 - Centro, Lucélia - SP, 17780-00, Brasil",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(151, 151, 151, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}
