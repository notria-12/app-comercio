import 'dart:convert';

class ProductService {
  String? id;
  String? link;
  String _imagePath;
  String _name;
  String _address;
  double _latitude;
  double _longitude;
  String _phoneNumber;
  String _phoneNumber2;
  List<dynamic> _catIds;
  String _description;

  // ProductService(this._imagePath, this._name, this._address, this._latitude,
  //     this._longitude, this._phoneNumber, this._phoneNumber2);

  ProductService(
      this._imagePath,
      this._name,
      this._address,
      this._latitude,
      this._longitude,
      this._phoneNumber,
      this._phoneNumber2,
      this._catIds,
      this._description,
      {this.id,
      this.link});

  String get name => _name;
  String get imagePath => _imagePath;
  String get address => _address;
  List<dynamic> get catIds => _catIds;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get phoneNumber => _phoneNumber;
  String get phoneNumber2 => _phoneNumber2;
  String get description => _description;

  Map<String, dynamic> toMap() {
    return {
      'est_urlimagem': _imagePath,
      'est_fantasia': _name,
      'est_address': _address,
      'est_latitude': _latitude,
      'est_longitude': _longitude,
      'est_catid': _catIds,
      'est_telefone01': _phoneNumber,
      'est_telefone02': _phoneNumber2,
      'descricao': _description,
      'est_link': link ?? ''
    };
  }

  factory ProductService.fromMap(Map map, {String? id}) {
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
        map['descricao'] ?? '',
        link: map['est_link'] ?? '',
        id: id);
  }

  String toJson() => json.encode(toMap());

  factory ProductService.fromJson(String source) =>
      ProductService.fromMap(json.decode(source));

  @override
  String toString() => 'ProductService(_imagePath: $_imagePath, _name: $_name)';

  @override
  int get hashCode => _imagePath.hashCode ^ _name.hashCode;

  ProductService copyWith(
      {String? imagePath,
      String? name,
      String? address,
      double? latitude,
      double? longitude,
      String? phoneNumber,
      String? phoneNumber2,
      List<dynamic>? catIds,
      String? description,
      String? linkExtra}) {
    return ProductService(
        imagePath ?? this._imagePath,
        name ?? this._name,
        address ?? this._address,
        latitude ?? this._latitude,
        longitude ?? this._longitude,
        phoneNumber ?? this._phoneNumber,
        phoneNumber2 ?? this._phoneNumber2,
        catIds ?? this._catIds,
        description ?? this._description,
        link: linkExtra ?? link);
  }
}
