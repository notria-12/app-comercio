import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.black12),
      child: Card(
        child: Row(
          children: [
            Container(
              height: 80,
              width: 85,
              child: Image.asset(
                'assets/img/eletro-fase.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.blueAccent,
              height: 80,
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
                      'Eletro Fase',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Alameda Demétrico Cavlak, 2094 - Centro, Lucélia',
                      style: TextStyle(fontSize: 10),
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
