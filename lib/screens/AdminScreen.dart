import 'package:flip/components/Common/Loader.dart';
import 'package:flip/components/common/Product.dart' as SingleProduct;
import 'package:flip/components/common/SnackBar.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Product.dart';
import 'package:flip/screens/AddProductScreen.dart';
import 'package:flip/services/admin.dart';
import 'package:flip/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final adminService = new AdminService();
  List<Product>? products;

  fetchAllProducts() async {
    final res = await adminService.fetchAllProducts(context: context);
    setState(() {
      products = res;
    });
  }

  deleteProduct(id, idx) async {
    adminService.deleteProduct(
        context: context,
        id: id,
        onSuccess: () {
          showSnackBar(context, 'Product removed successfully!');
          setState(() {
            products!.removeAt(idx);
          });
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchAllProducts();
  }

  void navigateToAddProduct() async {
    await Navigator.pushNamed(context, AddProductScreen.routeName);
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: products != null,
      replacement: const Loader(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 15),
          child: GridView.builder(
            itemCount: products?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final product = products![index];
              return Column(
                children: [
                  SizedBox(
                    height: 140,
                    child: SingleProduct.Product(image: product.images[0]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 12),
                          child: Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            deleteProduct(product.id, index);
                          },
                          icon: const Icon(Icons.delete_rounded))
                    ],
                  )
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: navigateToAddProduct,
          tooltip: 'Add a product',
          child: const Icon(Icons.add_rounded),
          backgroundColor: GlobalVariables.secondaryColor,
        ),
      ),
    );
  }
}
