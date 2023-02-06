import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flip/components/common/CustomButton.dart';
import 'package:flip/components/common/CustomTextField.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/helpers/pick_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-products';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  List<File> images = [];

  String category = "Mobiles";

  List<String> productCategories = [
    'Mobiles',
    "Essentails",
    "Appliances",
    "Books",
    "Fashion"
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _productDescriptionController.dispose();
    _productNameController.dispose();
    _productQuantityController.dispose();
    _productPriceController.dispose();
  }

  void selectImage() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
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
            title: Container(
              child: const Text(
                'Add Products',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
          child: Form(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: images.isEmpty,
              replacement: CarouselSlider(
                items: images.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) => Image.file(
                        i,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 200,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
              ),
              child: GestureDetector(
                onTap: selectImage,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: Colors.white,
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_open_rounded,
                            size: 40,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Select Product Image',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400,
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextField(
              controller: _productNameController,
              placeHolder: 'Product name',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _productDescriptionController,
              placeHolder: 'Description',
              maxLines: 7,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _productPriceController,
              placeHolder: 'Price',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: _productQuantityController,
              placeHolder: 'Quantity',
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButton(
                onChanged: (String? val) {
                  setState(() {
                    category = val!;
                  });
                },
                value: category,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: productCategories.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(text: 'Sell', onTap: () {})
          ],
        ),
      ))),
    );
  }
}
