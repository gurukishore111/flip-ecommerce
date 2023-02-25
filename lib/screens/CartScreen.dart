import 'package:flip/components/Cart/CartProduct.dart';
import 'package:flip/components/Cart/SubTotal.dart';
import 'package:flip/components/Common/CustomButton.dart';
import 'package:flip/components/Home/AddressBar.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/providers/user.dart';
import 'package:flip/screens/AddressScreen.dart';
import 'package:flip/screens/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddressScreen(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBar(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: CustomButton(
                text: 'Proceed to Buy (${user.cart.length} items)',
                onTap: () => navigateToAddressScreen(sum),
                color: Colors.yellow[700],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            )
          ],
        ),
      ),
    );
  }
}
