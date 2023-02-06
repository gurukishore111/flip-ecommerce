import 'package:flip/constants/global_variables.dart';
import 'package:flip/screens/AddProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 1),
              child: Row(
                children: [
                  Text(
                    'FLIP.ECOM',
                    style: TextStyle(
                        color: GlobalVariables.secondaryColor,
                        fontSize: 24,
                        fontFamily: GoogleFonts.bebasNeue().fontFamily),
                  ),
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: const [
                  Text(
                    'Admin Portal',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
      body: const Center(child: Text("List of Products Screen")),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: 'Add a product',
        child: const Icon(Icons.add_rounded),
        backgroundColor: GlobalVariables.secondaryColor,
      ),
    );
  }
}
