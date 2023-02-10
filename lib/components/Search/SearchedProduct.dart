import 'package:flip/components/Common/Stars.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(rating: avgRating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Eligable for FREE shipping',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: GlobalVariables.secondaryColor),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      product.quantity > 0 ? 'In Stock' : 'Out of Stock',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                          color: product.quantity > 0
                              ? const Color.fromARGB(255, 90, 245, 147)
                              : const Color.fromARGB(255, 249, 172, 167)),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
