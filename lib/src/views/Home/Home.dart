import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/ProductServiceController.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/views/Category/Category.dart';
import 'package:loja_virtual/src/views/Product/ProductDetails.dart';
import 'package:loja_virtual/src/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final fb = FirebaseDatabase.instance;
  ProductServiceController productServiceController =
      ProductServiceController();
  late Future<List<ProductService>> _futureProducts;
  var list;

  @override
  void initState() {
    super.initState();
    _futureProducts = productServiceController.getProductServiceList();
  }

  @override
  Widget build(BuildContext context) {
    // final isPortrait =
    //     MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBar(list));
              }),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryPage()));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Categorias',
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

class SearchBar extends SearchDelegate<String> {
  final List<ProductService> productServiceList;

  SearchBar(this.productServiceList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            } else {
              query = '';
              showSuggestions(context);
            }
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, ''));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : productServiceList.where((product) {
            final productLower = product.name.toLowerCase();
            // print('Product $productLower');
            final queryLower = query.toLowerCase();

            return productLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : productServiceList.where((product) {
            final productLower = product.name.toLowerCase();
            // print('Product $productLower');
            final queryLower = query.toLowerCase();

            return productLower.contains(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<dynamic> suggestions) {
    return suggestions.length > 0
        ? ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = suggestions[index];

              return GestureDetector(
                child: ProductCard(suggestion),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductServiceDetails(suggestion)));
                },
              );
            },
          )
        : Center(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/img/search.png'),
                  Text(
                      'Procure pelo nome do estabelecimento, produto ou serviço',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                      textAlign: TextAlign.center)
                ],
              ),
            ),
          );
  }

  @override
  String get searchFieldLabel => 'Digite aqui';
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
