import 'package:loja_virtual/src/models/Category.dart';
import 'package:loja_virtual/src/repository/CategoryRepository.dart';

class CategoryController {
  final categoryRepository = CategoryRepository();

  Future<List<Category>> getCategoryList() async {
    List<Category> categories = [];

    return categoryRepository.getData().then((categoryList) {
      categoryList.forEach((k, v) {
        categories.add(Category.fromMap(v));
      });
      return categories;
    }).catchError((e) {
      print(e);
    });
  }
}
