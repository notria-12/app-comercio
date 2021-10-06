import 'package:flutter/material.dart';
import 'package:loja_virtual/src/views/Adverts/new_ad_page.dart';

class AdvertsPage extends StatefulWidget {
  const AdvertsPage({Key? key}) : super(key: key);

  @override
  _AdvertsPageState createState() => _AdvertsPageState();
}

class _AdvertsPageState extends State<AdvertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Anúncios'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.blue,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Você ainda não possui nenhum anúncio, adicione e aumente o seu alcance!",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Image.asset("assets/img/empty_state.png"),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NewAdPage()));
                },
                label: Text("Novo Anúncio"),
                icon: Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
