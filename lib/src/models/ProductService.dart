import 'dart:convert';

class ProductService {
  String _imagePath;
  String _name;
  // String _address;

  ProductService(this._imagePath, this._name);

  // ProductService copyWith({
  //   String? _imagePath,
  //   String? _name,
  // }) {
  //   return ProductService(
  //     _imagePath ?? this._imagePath,
  //     _name ?? this._name,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': _imagePath,
      'name': _name,
    };
  }

  factory ProductService.fromMap(Map<String, dynamic> map) {
    return ProductService(
      map['_imagePath'],
      map['_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductService.fromJson(String source) =>
      ProductService.fromMap(json.decode(source));

  @override
  String toString() => 'ProductService(_imagePath: $_imagePath, _name: $_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductService &&
        other._imagePath == _imagePath &&
        other._name == _name;
  }

  @override
  int get hashCode => _imagePath.hashCode ^ _name.hashCode;
}
