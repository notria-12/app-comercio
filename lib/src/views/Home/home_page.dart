import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/CategoryController.dart';
import 'package:loja_virtual/src/controllers/ProductServiceController.dart';
import 'package:loja_virtual/src/models/Category.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/shared/widgets/drawer_widget.dart';
import 'package:loja_virtual/src/shared/widgets/product_card.dart';
import 'package:loja_virtual/src/views/Category/category_page.dart';
import 'package:loja_virtual/src/views/Product/product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final fb = FirebaseDatabase.instance;
  ProductServiceController productServiceController =
      ProductServiceController();
  CategoryController categoryController = CategoryController();
  late Future<List<Category>> _futureCategories;
  late Future<List<ProductService>> _futureProducts;
  var productsList;
  var categoriesList;
  bool serachByname = true;

  @override
  void initState() {
    super.initState();
    _futureProducts = productServiceController.getProductServiceList();
    _futureCategories = categoryController.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.favorite_border))
        ],
        bottom: PreferredSize(
          child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white38),
                      height: 25,
                      width: 80,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Center(
                        child: Text(
                          "Descrição",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // onTap: () => onSelectedItem(0),
                  ),
                  GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        height: 25,
                        width: 80,
                        child: Center(
                          child: Text(
                            "Categoria",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => CategoryPage()))),
                ],
              )),
          preferredSize: Size.fromHeight(30),
        ),
        title: GestureDetector(
          onTap: () {
            showSearch(
                context: context,
                delegate:
                    SearchBar(productsList, categoriesList, serachByname));
          },
          child: Container(
            padding: EdgeInsets.all(8),
            height: 35,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black26,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    'Busque aqui...',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black26, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      body: Column(
        children: [
          // Container(
          //   width: double.maxFinite,
          //   color: Colors.white,
          //   padding: EdgeInsets.symmetric(vertical: 6),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         flex: 1,
          //         child: InkWell(
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => CategoryPage()));
          //           },
          //           child: Container(
          //             padding: EdgeInsets.all(10),
          //             child: Text(
          //               'Categorias',
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.blueAccent,
          //                   fontSize: 16),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 1,
          //         child: InkWell(
          //           onTap: () {
          //             print('Sensacional');
          //           },
          //           child: Container(
          //             padding: EdgeInsets.all(10),
          //             child: Text(
          //               'Filtros',
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.blueAccent,
          //                   fontSize: 16),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
              child: FutureBuilder<List>(
            future: Future.wait([_futureProducts, _futureCategories]),
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
                  if (snapshot.hasData) {
                    productsList =
                        snapshot.data != null ? snapshot.data![0] : [];
                    categoriesList =
                        snapshot.data != null ? snapshot.data![1] : [];
                    return ListView.builder(
                      itemCount:
                          snapshot.data != null ? snapshot.data![0].length : 0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: ProductCard(productsList[index]),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductServiceDetails(
                                        productsList[index])));
                          },
                        );
                      },
                    );
                  } else {
                    print(snapshot.error);
                    return Center(
                      child: Text('Aconteceu um erro'),
                    );
                  }
                default:
                  return Text('Default');
              }
            },
          ))
        ],
      ),
    );
  }

  onSelectedItem(int item) {
    switch (item) {
      case 0:
        serachByname = true;
        setState(() {});

        break;
      case 1:
        serachByname = false;
        setState(() {});
        break;
    }
  }
}

class ButtonSearch extends StatelessWidget {
  final String label;
  final bool searchByName;
  const ButtonSearch(
    this.label,
    this.searchByName, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return searchByName
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            height: 25,
            width: 80,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                    color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white38),
            height: 25,
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
  }
}

class SearchBar extends SearchDelegate<String> {
  final List<ProductService> productServiceList;
  final List<Category> categories;
  final bool searchByname;

  SearchBar(this.productServiceList, this.categories, this.searchByname);

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

  List<ProductService> getSuggestions() {
    List<ProductService> products = [];

    categories.forEach((category) {
      final categoryLower = category.description.toLowerCase();
      final queryLower = query.toLowerCase();

      products = [
        if (categoryLower.contains(queryLower))
          ...productServiceList
              .where((product) => product.catIds.contains(category.id))
              .toList(),
        ...products
      ];
    });

    return query.isEmpty
        ? []
        : searchByname
            ? productServiceList.where((product) {
                final productLower = product.name.toLowerCase();

                final queryLower = query.toLowerCase();

                return productLower.contains(queryLower);
              }).toList()
            : products;
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestions = getSuggestions();

    return buildSuggestionsSuccess(suggestions);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = getSuggestions();
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
