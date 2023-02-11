import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip/components/Common/CustomButton.dart';
import 'package:flip/components/Common/CustomTextField.dart';
import 'package:flip/components/Common/Loader.dart';
import 'package:flip/components/Common/SnackBar.dart';
import 'package:flip/components/Common/Stars.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/models/Product.dart';
import 'package:flip/providers/user.dart';
import 'package:flip/screens/SearchScreen.dart';
import 'package:flip/services/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = "/product-details";
  final Product product;

  const ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductServices productServices = ProductServices();
  final TextEditingController _reviewController = TextEditingController();
  late Product productDetails = widget.product;

  final _reviewFormKey = GlobalKey<FormState>();

  double avgRating = 0;
  double myRating = 0;
  double newRating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductDetails();
  }

  void calculateRating() {
    if (productDetails.id != null) {
      double totalRating = 0;
      for (int i = 0; i < productDetails.rating!.length; i++) {
        totalRating += productDetails.rating![i].rating;
        if (productDetails.rating![i].userId ==
            Provider.of<UserProvider>(context, listen: false).user.id) {
          myRating = productDetails.rating![i].rating;
          setState(() {
            _reviewController.text = productDetails.rating![i].review;
            newRating = productDetails.rating![i].rating;
          });
        }
      }
      if (totalRating != 0) {
        avgRating = totalRating / productDetails.rating!.length;
      }
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  Future fetchProductDetails() async {
    var res = await productServices.fetchProductsById(
      context: context,
      id: productDetails.id!,
    );
    setState(() {
      productDetails = res;
    });
    calculateRating();
    setState(() {});
  }

  Future submitReview() async {
    if (newRating > 0) {
      await productServices.rateProduct(
        context: context,
        product: productDetails,
        rating: newRating,
        review: _reviewController.text,
      );
      Navigator.of(context).pop();
      fetchProductDetails();
    } else {
      showSnackBar(context, 'Please select a rating star!');
      Navigator.of(context).pop();
    }
  }

  startAddReview(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          // solution for tap close
          // return GestureDetector(
          //   onTap: () {
          //     print('object');
          //   },
          //   child: NewTransaction(addNewTransaction: _addNewTransaction),
          //   behavior: HitTestBehavior.opaque,
          // );
          return Container(
            margin: const EdgeInsets.only(top: 20, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    "Rate The Product",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: ((context, index) {
                    return const Icon(Icons.star_rounded,
                        color: GlobalVariables.secondaryColor);
                  }),
                  onRatingUpdate: (rating) {
                    // productServices.rateProduct(
                    //     context: context, product: productDetails, rating: rating);
                    setState(() {
                      newRating = rating;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Form(
                    key: _reviewFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          maxLines: 3,
                          placeHolder: 'Product review',
                          controller: _reviewController,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            text: 'Submit',
                            onTap: () {
                              if (_reviewFormKey.currentState!.validate()) {
                                submitReview();
                              }
                            }),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
        visible: productDetails.id != null,
        replacement: const Loader(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productDetails.id!,
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade500),
                    ),
                    Stars(rating: avgRating)
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  productDetails.name,
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade300),
                ),
              ),
              CarouselSlider(
                items: productDetails.images.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) => Image.network(
                        i,
                        fit: BoxFit.contain,
                        height: 350,
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 350,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: RichText(
                  text: TextSpan(
                      text: "Deal Price: ",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade400),
                      children: [
                        TextSpan(
                          text: "\$${productDetails.price}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w200,
                            color: GlobalVariables.secondaryColor,
                          ),
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  productDetails.description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(text: 'Buy Now', onTap: () {}),
              ),
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                  text: 'Add to Cart',
                  onTap: () {},
                  color: const Color.fromRGBO(254, 216, 19, 1),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Visibility(
                visible: myRating > 0,
                replacement: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: GestureDetector(
                      onTap: () => startAddReview(context),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Add Review ",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: GlobalVariables.secondaryColor,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                )),
                            const WidgetSpan(
                              child: Icon(
                                Icons.add_circle_outline_outlined,
                                size: 22,
                                color: GlobalVariables.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                    // Text(
                    //   'Add Review',
                    //   style: TextStyle(
                    //       fontSize: 16, color: GlobalVariables.secondaryColor),
                    // ),
                    ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => startAddReview(context),
                        child: const Text(
                          'Your Review',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                  children: productDetails.rating!.map((rating) {
                return Visibility(
                  visible: rating.userId == user.id,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://api.dicebear.com/5.x/bottts-neutral/png?seed=${rating.username}",
                      ),
                    ),
                    title: Text(rating.review),
                    subtitle: Stars(rating: rating.rating),
                    trailing: PopupMenuButton(
                      onSelected: ((value) {
                        if (value == 'edit') {
                          startAddReview(context);
                        } else if (value == 'delete') {
                          productServices.deleteRating(
                            context: context,
                            product: productDetails,
                            onSuccessCallback: () {
                              setState(() {
                                myRating = 0;
                                fetchProductDetails();
                              });
                            },
                          );
                        }
                      }),
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            child: Text(
                              'Edit',
                              style: TextStyle(fontSize: 15),
                            ),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Delete',
                              style: TextStyle(fontSize: 15),
                            ),
                            value: 'delete',
                          ),
                        ];
                      },
                    ),
                  ),
                );
              }).toList()),
              Visibility(
                visible: avgRating > 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Other Reviews',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Average rating $avgRating/5',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                  children: productDetails.rating!.map((rating) {
                return Visibility(
                  visible: rating.userId != user.id,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://api.dicebear.com/5.x/bottts-neutral/png?seed=${rating.username}",
                      ),
                    ),
                    title: Text(rating.review),
                    subtitle: Text(rating.username),
                    trailing: Stars(rating: rating.rating),
                  ),
                );
              }).toList()),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
