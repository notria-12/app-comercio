import 'package:flutter/material.dart';
// import 'package:loja_virtual/src/views/Login/login_page.dart';

class DrawerAuthWidget extends StatelessWidget {
  const DrawerAuthWidget(
      {Key? key,
      required this.userEmail,
      required this.establishmentName,
      required this.urlImage})
      : super(key: key);
  final String userEmail;
  final String establishmentName;
  final urlImage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Container(
            // color: Colors.lightBlue,
            padding: EdgeInsets.only(bottom: 8),
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Container(
                    child: Center(child: Image.network(urlImage)),
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  establishmentName,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  userEmail,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                )
              ],
            ),
          ),
        ),
        ItemDrawerWidget(
          Icon(Icons.home, color: Color.fromRGBO(151, 151, 151, 1)),
          'Início',
          () {
            Navigator.of(context).pop();
          },
        ),
        ItemDrawerWidget(
          Icon(Icons.store, color: Color.fromRGBO(151, 151, 151, 1)),
          'Meu Estabelecimento',
          () {
            print('clicou');
          },
        ),
        ItemDrawerWidget(
          Icon(Icons.logout, color: Color.fromRGBO(151, 151, 151, 1)),
          'Sair',
          () async {
            return await showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                    title: new Text('Tem certeza?'),
                    content:
                        new Text('Realmente deseja sair da área de acesso?'),
                    actions: <Widget>[
                      new GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Text("NÃO"),
                      ),
                      SizedBox(height: 16),
                      new GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop(true);
                          Navigator.of(context).pop(true);
                        },
                        child: Text("SIM"),
                      ),
                    ],
                  ),
                ) ??
                false;
          },
        ),
      ],
    ));
  }
}

class ItemDrawerWidget extends StatelessWidget {
  Icon icon;
  String label;
  Function onTap;

  ItemDrawerWidget(
    this.icon,
    this.label,
    this.onTap, {

    // required onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 25,
            ),
            Text(
              label,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 0.87)),
            )
          ],
        ),
      ),
    );
  }
}
