import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewAdPage extends StatefulWidget {
  const NewAdPage({Key? key}) : super(key: key);

  @override
  _NewAdPageState createState() => _NewAdPageState();
}

class _NewAdPageState extends State<NewAdPage> {
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo anúncio"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("Título")),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(label: Text('Duração(dias)')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
