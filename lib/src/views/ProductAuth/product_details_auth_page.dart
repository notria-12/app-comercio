import 'package:flutter/material.dart';
import 'package:loja_virtual/src/controllers/CategoryController.dart';
import 'package:loja_virtual/src/models/Category.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/views/EditProduct/edit_product_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductServiceDetailsAuth extends StatefulWidget {
  final ProductService _productService;
  final String? productId;
  const ProductServiceDetailsAuth(this._productService,
      {Key? key, this.productId})
      : super(key: key);

  @override
  _ProductServiceDetailsState createState() => _ProductServiceDetailsState();
}

class _ProductServiceDetailsState extends State<ProductServiceDetailsAuth> {
  final categoryController = CategoryController();
  late Future<List<Category>> _categories;
  late ProductService auxProduct;

  @override
  void initState() {
    super.initState();

    _categories =
        categoryController.getCategoryForId(widget._productService.catIds);
    auxProduct = widget._productService;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context, auxProduct);
            },
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  final result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => EditProductPage(
                                productService: auxProduct,
                                productId: widget.productId,
                              )));

                  if (result != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Estabelecimento atualizado')));

                    setState(() {
                      auxProduct = result;
                    });
                  }
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                var list = snapshot.data ?? [];
                // print(list);
                String cats = '';
                for (var i = 0; i < list.length; i++) {
                  if (i < list.length - 1) {
                    cats += list[i].description + ', ';
                  } else {
                    cats += list[i].description;
                  }
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          color: Colors.black12,
                          child: Center(
                            child: Image.network(auxProduct.imagePath),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          auxProduct.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          auxProduct.address,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          height: 4,
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Descrição',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          auxProduct.description,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          height: 4,
                          color: Colors.black12,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Categoria',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cats,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return Text('Caiu no Default');
            }
          },
        ));
  }

  abrirGoogleMaps() async {
    String urlMap =
        'https://www.google.com/maps/search/?api=1&query=${widget._productService.latitude},${widget._productService.longitude}';
    if (await canLaunch(urlMap)) {
      await launch(urlMap);
    } else {
      throw 'Could not launch Maps';
    }
  }

  abrirWhatsApp() async {
    String number = '+55' +
        widget._productService.phoneNumber2.replaceAll(RegExp(r'\D'), '');
    if (number.isEmpty) {
      print('Sem numero');
    } else {
      var whatsappUrl = "whatsapp://send?phone=$number=Olá,tudo bem ?";

      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
      } else {
        throw 'Could not launch $whatsappUrl';
      }
    }
  }

  fazerLigacao() async {
    String number =
        widget._productService.phoneNumber.replaceAll(RegExp(r'\D'), '');
    // number = number.substring(0, 2) + '9' + number.substring(2, number.length - 1);
    var url = 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
