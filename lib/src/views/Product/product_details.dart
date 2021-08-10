import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loja_virtual/src/controllers/CategoryController.dart';
import 'package:loja_virtual/src/models/Category.dart';
import 'package:loja_virtual/src/models/ProductService.dart';
import 'package:loja_virtual/src/shared/widgets/expandable_fab.dart';

import 'package:url_launcher/url_launcher.dart';

class ProductServiceDetails extends StatefulWidget {
  final ProductService _productService;
  const ProductServiceDetails(this._productService, {Key? key})
      : super(key: key);

  @override
  _ProductServiceDetailsState createState() => _ProductServiceDetailsState();
}

class _ProductServiceDetailsState extends State<ProductServiceDetails> {
  final categoryController = CategoryController();
  late Future<List<Category>> _categories;

  @override
  void initState() {
    super.initState();

    _categories =
        categoryController.getCategoryForId(widget._productService.catIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: Icon(Icons.favorite_border_outlined))
          ],
        ),
        floatingActionButton: ExpandableFab(
          children: [
            FloatingActionButton(
              onPressed: () {
                abrirGoogleMaps();
              },
              child: Icon(Icons.map),
            ),
            FloatingActionButton(
              onPressed: () {
                fazerLigacao();
              },
              child: Icon(Icons.phone),
            ),
            FloatingActionButton(
                onPressed: () {
                  abrirWhatsApp();
                },
                child: FaIcon(FontAwesomeIcons.whatsapp)),
          ],
          distance: 100,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        // FloatingActionButton(
        //   onPressed: () {
        //     abrirGoogleMaps();
        //   },
        //   child: Icon(Icons.map),
        // ),
        // SizedBox(
        //   width: 8,
        // ),
        // FloatingActionButton(
        //     onPressed: () {
        //       abrirWhatsApp();
        //     },
        //     child: FaIcon(FontAwesomeIcons.whatsapp)),
        //   ],
        // ),
        body: FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                var list = snapshot.data ?? [];
                print(list);
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
                            child:
                                Image.network(widget._productService.imagePath),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget._productService.name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget._productService.address,
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
                          widget._productService.description,
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
