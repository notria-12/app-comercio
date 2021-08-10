import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/ProductServiceController.dart';
import 'package:loja_virtual/src/models/Category.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/shared/widgets/product_card.dart';
import 'package:loja_virtual/src/views/Product/ProductDetails.dart';

class StablichmentsPage extends StatefulWidget {
  final Category category;

  const StablichmentsPage(this.category, {Key? key}) : super(key: key);

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
        productServiceController.getStablichmentForCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtro Categoria'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.category.description,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.blueAccent),
            ),
            decoration: BoxDecoration(
                // color: Colors.grey,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10)),
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
                  list = snapshot.data ?? [];

                  return list.length > 0
                      ? ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: ProductCard(list[index]),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductServiceDetails(
                                                list[index])));
                              },
                            );
                          },
                        )
                      : Center(
                          child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/img/empty_state.png'),
                              Text(
                                  'Infelizmente ainda não temos produtos ou serviços pra essa categoria!',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 16),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ));

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
