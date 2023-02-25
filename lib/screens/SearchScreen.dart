import 'dart:convert';

import 'package:flip/components/Common/Loader.dart';
import 'package:flip/components/Home/AddressBar.dart';
import 'package:flip/components/Search/SearchedProduct.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Product.dart';
import 'package:flip/providers/user.dart';
import 'package:flip/screens/ProductDetailsScreen.dart';
import 'package:flip/services/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final productServices = new ProductServices();
  List<Product>? products;

  fetchAllProducts() async {
    final res = await productServices.searchProduct(
        context: context, query: widget.searchQuery);
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
    super.dispose();
    products = null;
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    var len = products?.length ?? 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Container(
                height: 42,
                // margin: const EdgeInsets.only(bottom: 35, top: 25),
                // alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 1, bottom: 1),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: navigateToSearchScreen,
                    decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search the product',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 37,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(bottom: 1),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://api.dicebear.com/5.x/bottts-neutral/png?seed=$user['name']",
                ),
              ),
            )
          ]),
        ),
      ),
      body: Visibility(
          visible: products != null,
          replacement: const Loader(),
          child: Column(
            children: [
              const AddressBar(),
              const SizedBox(
                height: 10,
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
                        "No result found for category - ${widget.searchQuery}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: products?.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailsScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchedProduct(
                          product: products![index],
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
