import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
  InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  String dropdownValue = "One";

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
              Container(
                width: double.maxFinite,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>[
                    'One',
                    'Two',
                    'Free',
                    'Four',
                    'Selecione uma cidade'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                child: Image.asset("assets/img/destination.png"),
              ),

              // ElevatedButton(
              //     onPressed: () {}, child: Text("Usar minha localização"))
            ],
          ),
        ),
      ),
    );
  }
}
