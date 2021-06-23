import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/ProductServiceController.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/views/Product/ProductDetails.dart';
import 'package:loja_virtual/src/widgets/product_card.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fb = FirebaseDatabase.instance;
  ProductServiceController productServiceController =
      ProductServiceController();
  // Future<List<ProductService>> _loadProductServices;

  @override
  void initState() {
    super.initState();
    // _loadProductServices = productServiceController.getProductServiceList();
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
                final result =
                    showSearch(context: context, delegate: SearchBar());
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
                  child: GestureDetector(
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
            future: productServiceController.getProductServiceList(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  }
                case ConnectionState.done:
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      var lista = snapshot.data ?? [];
                      return GestureDetector(
                        child: ProductCard(lista[index]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductServiceDetails(lista[index])));
                        },
                      );
                    },
                  );
                  break;
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
  final cities = ['Caxias', 'Teresina', 'Timon', 'São Luís', 'Natal', 'Palmas'];

  final recentCities = ['Caxias', 'Timon', 'Natal'];

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
    return Center(
      child: Column(
        children: [
          Icon(Icons.location_city, size: 120),
          const SizedBox(
            height: 48,
          ),
          Text(
            query,
            style: TextStyle(
                color: Colors.black, fontSize: 64, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities.where((city) {
            final cityLower = city.toLowerCase();
            final queryLower = query.toLowerCase();

            return cityLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          onTap: () {
            query = suggestion;

            showResults(context);
          },
          leading: Icon(Icons.location_city),
          title: Text(suggestion),
        );
      },
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
