import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String image;
  const Product({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade800,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12,
        ),
        child: Container(
          width: 180,
          padding: EdgeInsets.all(10),
          child: Image.network(
            image,
            fit: BoxFit.fitHeight,
            width: 180,
          ),
        ),
      ),
    );
  }
}
