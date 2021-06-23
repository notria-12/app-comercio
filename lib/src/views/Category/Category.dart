import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/CategoryController.dart';
import 'package:loja_virtual/src/models/Category.dart';

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
        height: 400,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Categorias',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                            return ListTile(
                              title: Text(categories[index].description),
                            );
                          },
                        );
                      }

                      break;
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
