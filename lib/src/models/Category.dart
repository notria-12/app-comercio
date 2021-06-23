import 'dart:convert';

class Category {
  String _id;
  String _description;

  Category(
    this._id,
    this._description,
  );

  String get id => _id;
  String get description => _description;

  Map<String, dynamic> toMap() {
    return {
      'cat_id': _id,
      'cat_descricao': _description,
    };
  }

  factory Category.fromMap(Map map) {
    return Category(map['cat_id'], map['cat_descricao']);
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Category(_id: $_id, _description: $_description)';
}
