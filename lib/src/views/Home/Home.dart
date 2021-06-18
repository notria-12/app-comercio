import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/src/views/Product/ProductDetails.dart';
import 'package:loja_virtual/src/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () => {}, icon: Icon(Icons.favorite_border))
        ],
      ),
      drawer: Drawer(
        child: Container(),
      ),
      body: Column(
        children: [
          Container(
            // height: 40,
            width: double.maxFinite,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // color: Colors.black12,
                      child: Text(
                        'Categoria',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                        // style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // VerticalDivider(
                //   color: Colors.amberAccent,
                //   width: 3,
                //   thickness: 5,
                // ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    // mouseCursor: MouseCursor.defer,
                    onTap: () {
                      print('Sensacional');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // color: Colors.black12,
                      child: Text(
                        'Filtros',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  child: ProductCard(),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductServiceDetails()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
