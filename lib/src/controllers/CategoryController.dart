import 'package:loja_virtual/src/models/Category.dart';
import 'package:loja_virtual/src/repository/category_repository.dart';

class CategoryController {
  final categoryRepository = CategoryRepository();

  Future<List<Category>> getCategoryList() async {
    List<Category> categories = [];

    return categoryRepository.getData().then((categoryList) {
      categoryList.forEach((k, v) {
        categories.add(Category.fromMap(v));
      });
      categories.sort((a, b) => a.description.compareTo(b.description));
      return categories;
    }).catchError((e) {
      print(e);
    });
  }

  Future<List<Category>> getCategoryForId(List catId) async {
    List<Category> categories = [];
    print('Categories $catId');

    return categoryRepository.getData().then((categoryList) {
      categoryList.forEach((k, v) {
        if (catId.contains(v['cat_id'])) {
          categories.add(Category.fromMap(v));
        }
      });
      return categories;
    }).catchError((e) {
      print(e);
    });
  }
}
