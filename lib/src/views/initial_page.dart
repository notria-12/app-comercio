import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loja_virtual/src/controllers/city_controller.dart';
import 'package:loja_virtual/src/models/city_model.dart';
import 'package:loja_virtual/src/views/Home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late Future<List<City>> citiesList;
  String dropdownValue = "Selecione uma cidade";
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    citiesList = CityController().getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.maxFinite,
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "Vamos começar!",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 26,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Informe sua localidade e encontraremos estabelecimentos para você!",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              FutureBuilder<List<City>>(
                  future: citiesList,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('Aconteceu um erro inesperado');
                        } else {
                          return Form(
                            key: _formKey,
                            child: Container(
                                width: double.maxFinite,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  )),
                                  value: dropdownValue,
                                  // icon: const Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  // underline: Container(
                                  //   height: 2,
                                  //   color: Colors.deepPurpleAccent,
                                  // ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                  validator: (item) {
                                    if (dropdownValue ==
                                        "Selecione uma cidade") {
                                      return "É necessário selecionar a cidade";
                                    }
                                  },
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: "Selecione uma cidade",
                                      child: Text("Selecione uma cidade"),
                                    ),
                                    ...snapshot.data!
                                        .map<DropdownMenuItem<String>>(
                                            (City city) {
                                      return DropdownMenuItem<String>(
                                        value: city.name,
                                        child: Text(city.name),
                                      );
                                    }).toList()
                                  ],
                                )),
                          );
                        }
                      default:
                        return Text('Caiu no padrão');
                    }
                  }),
              Container(
                child: Image.asset("assets/img/destination.png"),
              ),
              Container(
                width: double.maxFinite,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _preferences = await SharedPreferences.getInstance();
                        _preferences.setString("city", dropdownValue);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                HomePage(cityName: dropdownValue)));
                      }
                    },
                    child: Text("Avançar"),
                  ),
                ),
                // alignment: Alignment.centerLeft,
              )
            ],
          ),
        ),
      ),
    );
  }
}
