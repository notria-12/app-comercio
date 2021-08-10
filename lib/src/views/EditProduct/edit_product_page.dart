import 'package:flutter/material.dart';
import 'package:loja_virtual/src/models/ProductService.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage(
      {Key? key, required this.productService, this.productId})
      : super(key: key);
  final ProductService productService;
  final String? productId;

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Tem certeza?'),
                content:
                    new Text('Realmente deseja sair e descartar alterações?'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("NÃO"),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: Text("SIM"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Editar estabelecimento'),
          centerTitle: true,
          leading: Container(),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Form(
                      child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Nome estabelecimento',
                          labelText: 'Nome estabelecimento',
                        ),
                        initialValue: widget.productService.name,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Endereço',
                          labelText: 'Endereço',
                        ),
                        initialValue: widget.productService.address,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Descrição',
                          labelText: 'Descrição',
                        ),
                        initialValue: widget.productService.description,
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
