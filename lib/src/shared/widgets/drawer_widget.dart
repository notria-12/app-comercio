import 'package:flutter/material.dart';
import 'package:loja_virtual/src/views/Category/category_page.dart';
import 'package:loja_virtual/src/views/Login/login_page.dart';
import 'package:loja_virtual/src/views/initial_page.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Image.asset('assets/img/stablishment_logo.png'),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Possui algum estabelecimento?",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: Text(
                    "Clique aqui para logar",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
        // ItemDrawerWidget(
        //   Icon(Icons.search, color: Color.fromRGBO(151, 151, 151, 1)),
        //   'Buscar',
        //   () {
        //     print('clicou');
        //   },
        // ),
        ItemDrawerWidget(
          Icon(Icons.category, color: Color.fromRGBO(151, 151, 151, 1)),
          'Categorias',
          () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CategoryPage()));
          },
        ),
        ItemDrawerWidget(
          Icon(Icons.map, color: Color.fromRGBO(151, 151, 151, 1)),
          'Mudar de cidade',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => InitialPage()),
            );
          },
        ),
        // ItemDrawerWidget(
        //   Icon(Icons.favorite, color: Color.fromRGBO(151, 151, 151, 1)),
        //   'Meus favoritos',
        //   () {
        //     print('clicou');
        //   },
        // )
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
