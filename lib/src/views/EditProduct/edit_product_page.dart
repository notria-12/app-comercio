import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/ProductServiceController.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
// import 'package:camera_camera/camera_camera.dart';

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
  String? name, address, description, link;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    name = widget.productService.name;
    address = widget.productService.address;
    description = widget.productService.description;
    link = widget.productService.link;

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
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Nome estabelecimento',
                              labelText: 'Nome estabelecimento',
                            ),
                            initialValue: name,
                            onSaved: (String? val) {
                              name = val;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Endereço',
                              labelText: 'Endereço',
                            ),
                            initialValue: address,
                            onSaved: (String? val) {
                              address = val;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Link adicional',
                              labelText: 'Link adicional',
                            ),
                            initialValue: link,
                            onSaved: (String? val) {
                              link = val;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            maxLines: 6,
                            maxLength: 600,
                            decoration: InputDecoration(
                                hintText: 'Descrição',
                                labelText: 'Descrição',
                                border: OutlineInputBorder()),
                            initialValue: description,
                            onSaved: (String? val) {
                              description = val;
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _sendForm,
          child: Icon(Icons.save),
        ),
      ),
    );
  }

  _sendForm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ProductService newProductService = widget.productService.copyWith(
          name: name,
          description: description,
          address: address,
          linkExtra: link);

      try {
        ProductServiceController productServiceController =
            ProductServiceController();
        await productServiceController.updateStabblishment(
            widget.productId!, newProductService);
        Navigator.pop(context, newProductService);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Erro ao salvar, verifique sua conexão com a internet')));
      }

      // setState(() {});
    } else {
      // erro de validação
      // setState(() {
      //   _validate = true;
      // });
    }
  }
}
