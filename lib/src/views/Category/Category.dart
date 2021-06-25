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
                        var categories = snapshot.data ?? [];
                        return ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StablichmentsPage(
                                            categories[index])));
                              },
                              splashColor: Colors.blueAccent,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 2),
                                color: Colors.white,
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        categories[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            );
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
