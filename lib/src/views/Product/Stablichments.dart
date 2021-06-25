import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/ProductServiceController.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/views/Product/ProductDetails.dart';
import 'package:loja_virtual/src/widgets/product_card.dart';

class StablichmentsPage extends StatefulWidget {
  final String catId;

  const StablichmentsPage(this.catId, {Key? key}) : super(key: key);

  @override
  _StablichmentsPageState createState() => _StablichmentsPageState();
}

class _StablichmentsPageState extends State<StablichmentsPage> {
  ProductServiceController productServiceController =
      ProductServiceController();
  late Future<List<ProductService>> _futureProducts;
  var list;

  @override
  void initState() {
    super.initState();
    _futureProducts =
        productServiceController.getStablichmentForCategory(widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // Expanded(
                //   flex: 1,
                //   child: InkWell(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => CategoryPage()));
                //     },
                //     child: Container(
                //       padding: EdgeInsets.all(10),
                //       child: Text(
                //         'Categorias',
                //         style: TextStyle(
                //             fontWeight: FontWeight.w600,
                //             color: Colors.blueAccent,
                //             fontSize: 16),
                //         textAlign: TextAlign.center,
                //         // style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  flex: 1,
                  child: InkWell(
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
              child: FutureBuilder<List<ProductService>>(
            future: _futureProducts,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case ConnectionState.done:
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      list = snapshot.data ?? [];
                      return GestureDetector(
                        child: ProductCard(list[index]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductServiceDetails(list[index])));
                        },
                      );
                    },
                  );

                default:
                  return Text('Default');
              }
            },
          ))
        ],
      ),
    );
  }
}
