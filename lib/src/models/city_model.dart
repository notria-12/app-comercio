import 'dart:convert';

class City {
  String ibgeCode;
  String name;

  City({
    required this.ibgeCode,
    required this.name,
  });

  City copyWith({
    String? ibgeCode,
    String? name,
  }) {
    return City(
      ibgeCode: ibgeCode ?? this.ibgeCode,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ibge': ibgeCode,
      'nome': name,
    };
  }

  factory City.fromMap(map) {
    return City(
      ibgeCode: map['ibge'] ?? "",
      name: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source));

  @override
  String toString() => 'City(ibgeCode: $ibgeCode, name: $name)';
}
