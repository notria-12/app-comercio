import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/CategoryController.dart';
import 'package:loja_virtual/src/models/Category.dart';
import 'package:loja_virtual/src/views/Product/Stablichments.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<Category>> _futureCategories;
  CategoryController categoryController = CategoryController();
  var categories;
  @override
  void initState() {
    super.initState();

    _futureCategories = categoryController.getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBar(categories));
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        color: Colors.black12,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Categorias',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.blueAccent),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: _futureCategories,
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
                      {
                        categories = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return CategoryCard(categorie: categories[index]);
                          },
                        );
                      }
                    default:
                      return Text('DEFAULT');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.categorie,
  }) : super(key: key);

  final Category categorie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StablichmentsPage(categorie)));
      },
      splashColor: Colors.blueAccent,
      child: Container(
        margin: EdgeInsets.only(bottom: 2),
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                categorie.description,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}

class SearchBar extends SearchDelegate<String> {
  final List<Category> categoriesList;

  SearchBar(this.categoriesList);

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
        : categoriesList.where((category) {
            final categoryLower = category.description.toLowerCase();
            // print('category $categoryLower');
            final queryLower = query.toLowerCase();

            return categoryLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : categoriesList.where((category) {
            final categoryLower = category.description.toLowerCase();
            // print('category $categoryLower');
            final queryLower = query.toLowerCase();

            return categoryLower.startsWith(queryLower);
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
                child: CategoryCard(
                  categorie: suggestion,
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ProductServiceDetails(suggestion)));
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
}
