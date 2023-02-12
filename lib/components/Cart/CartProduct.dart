import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Product.dart';
import 'package:flip/providers/user.dart';
import 'package:flip/services/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductServices productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    final productCart =
        Provider.of<UserProvider>(context).user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    void increaseQuantity(productCart) {
      productServices.addToCart(context: context, product: productCart);
    }

    void decreaseQuantity(productCart) {
      productServices.removeFromCart(context: context, product: productCart);
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
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade600,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade900,
                ),
                child: Row(children: [
                  InkWell(
                    onTap: () => decreaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.remove_rounded,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade800,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(0)),
                    child: Container(
                        width: 35,
                        height: 32,
                        color: Colors.black26,
                        alignment: Alignment.center,
                        child: Text(quantity.toString())),
                  ),
                  InkWell(
                    onTap: () => increaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add_rounded,
                        size: 18,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        )
      ],
    );
  }
}
