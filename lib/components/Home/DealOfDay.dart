import 'package:flip/components/Common/Loader.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Product.dart';
import 'package:flip/screens/CategoryDeals.dart';
import 'package:flip/screens/ProductDetailsScreen.dart';
import 'package:flip/services/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final productServices = new ProductServices();
  List<Product>? products;

  fetchAllProducts() async {
    final res = await productServices.fetchDealOfTheDay(context: context);
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
  Widget build(BuildContext context) {
    var len = products?.length ?? 0;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.black38),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Text("Deal of the Day"),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black38),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Visibility(
            visible: len > 0,
            replacement: Loader(),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                    arguments: products![0]);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Image.network(
                      products![0].images[0],
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products![0].name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          products![0].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '\$${products![0].price}',
                          style: TextStyle(
                            color: GlobalVariables.secondaryColor,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ...products!.map((product) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                      arguments: product);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    product!.images[0],
                    fit: BoxFit.fitWidth,
                    width: 100,
                    height: 100,
                  ),
                ),
              );
            }).toList(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CategoryDealsScreen.routeName,
                    arguments: 'Mobiles');
              },
              child: Container(
                padding: EdgeInsets.all(20),
                child: const Text(
                  "See all deals",
                  style: TextStyle(
                    color: GlobalVariables.secondaryColor,
                  ),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
