import 'dart:convert';

class ProductService {
  // String _id;
  String _imagePath;
  String _name;
  String _address;
  double _latitude;
  double _longitude;
  String _phoneNumber;
  String _phoneNumber2;
  List<dynamic> _catIds;

  // ProductService(this._imagePath, this._name, this._address, this._latitude,
  //     this._longitude, this._phoneNumber, this._phoneNumber2);

  ProductService(this._imagePath, this._name, this._address, this._latitude,
      this._longitude, this._phoneNumber, this._phoneNumber2, this._catIds);

  String get name => _name;
  String get imagePath => _imagePath;
  String get address => _address;
  List<dynamic> get catIds => _catIds;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get phoneNumber => _phoneNumber;
  String get phoneNumber2 => _phoneNumber2;

  Map<String, dynamic> toMap() {
    return {
      'est_urlimagem': _imagePath,
      'est_fantasia': _name,
      'est_address': _address,
      'est_latitude': _latitude,
      'est_longitude': _longitude,
      'est_catid': _catIds,
      'est_telefone01': _phoneNumber,
      'est_telefone02': _phoneNumber2
    };
  }

  factory ProductService.fromMap(Map map) {
    return ProductService(
      map['est_urlimagem'] ??
          'https://img.freepik.com/vetores-gratis/ilustracao-de-um-loja-padaria_53876-26746.jpg?size=338&ext=jpg',
      map['est_fantasia'] ?? 'Sem nome',
      map['est_address'] ?? 'Sem endereço',
      map['est_latitude'] ?? 0,
      map['est_longitude'] ?? 0,
      map['est_telefone01'] ?? '',
      map['est_telefone02'] ?? '',
      map['est_catid'].map((cat) {
        return cat.toString();
      }).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductService.fromJson(String source) =>
      ProductService.fromMap(json.decode(source));

  @override
  String toString() => 'ProductService(_imagePath: $_imagePath, _name: $_name)';

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is ProductService &&
  //       other._imagePath == _imagePath &&
  //       other._name == _name;
  // }

  @override
  int get hashCode => _imagePath.hashCode ^ _name.hashCode;
}
