import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black12),
      child: Row(
        children: [
          Expanded(
              child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/comercio-6d23d.appspot.com/o/img_estab%2F-MV7bV82uiGR2aVZAG2g?alt=media&token=25156e81-c7f8-4446-aa6e-5bfd54615a74',
            scale: 1,
          ))
        ],
      ),
    );
  }
}
