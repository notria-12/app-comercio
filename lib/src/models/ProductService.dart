import 'dart:convert';

class ProductService {
  // String _id;
  String _imagePath;
  String _name;
  String _address;

  ProductService(this._imagePath, this._name, this._address);

  // ProductService copyWith({
  //   String? _imagePath,
  //   String? _name,
  // }) {
  //   return ProductService(
  //     _imagePath ?? this._imagePath,
  //     _name ?? this._name,
  //   );
  // }

  String get name => _name;
  String get imagePath => _imagePath;
  String get address => _address;

  Map<String, dynamic> toMap() {
    return {
      'est_urlimagem': _imagePath,
      'est_fantasia': _name,
      'est_address': _address
    };
  }

  factory ProductService.fromMap(Map map) {
    return ProductService(
      map['est_urlimagem'] ??
          'https://img.freepik.com/vetores-gratis/ilustracao-de-um-loja-padaria_53876-26746.jpg?size=338&ext=jpg',
      map['est_fantasia'] ?? 'Sem nome',
      map['est_address'] ?? 'Sem endereço',
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
