import 'dart:convert';

import 'package:flip/components/Common/Loader.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Product.dart';
import 'package:flip/services/product.dart';
import 'package:flutter/material.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final productServices = new ProductServices();
  List<Product>? products;

  fetchAllProducts() async {
    final res = await productServices.fetchProductsByCategory(
        context: context, category: widget.category);
    setState(() {
      products = res;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    products = null;
  }

  @override
  Widget build(BuildContext context) {
    var len = products?.length ?? 0;

    print(jsonEncode(products));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Text(
              '${widget.category}',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            )),
      ),
      body: Visibility(
        visible: products != null,
        replacement: const Loader(),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'Keep shopping for ${widget.category}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Visibility(
            visible: len > 0,
            replacement: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.description_rounded,
                    size: 110,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No result found for category - ${widget.category}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            child: SizedBox(
              height: 170,
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                itemCount: products?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.4),
                itemBuilder: ((context, index) {
                  final product = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade700, width: 0.5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.network(product.images[0]),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding:
                            const EdgeInsets.only(left: 0, top: 5, right: 15),
                        child: Text(
                          product.name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
