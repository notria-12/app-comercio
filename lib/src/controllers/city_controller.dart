import 'package:loja_virtual/src/models/city_model.dart';
import 'package:loja_virtual/src/repository/city_repository.dart';

class CityController {
  final _repository = CityRepository();

  Future<List<City>> getCities() async {
    List<City> cities = [];
    try {
      return _repository.getCities().then((citiesList) {
        citiesList.forEach((key, value) {
          City city = City.fromMap(value);
          cities.add(city);
          // print(value);
        });
        return cities;
      });
    } catch (e) {
      throw e;
    }
  }
}
