import 'package:flutter/material.dart';
import 'package:loja_virtual/src/models/ProductService.dart';

class ProductCard extends StatelessWidget {
  final ProductService _productService;
  const ProductCard(this._productService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black12),
      child: Card(
        child: Row(
          children: [
            Container(
              height: 90,
              width: 90,
              child: Image.network(
                _productService.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.blueAccent,
              height: 90,
              width: 3,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 4),
                height: 80,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      _productService.name,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      _productService.address,
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
