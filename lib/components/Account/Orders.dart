import 'package:flip/components/common/Product.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    // dummy Data

    List tempData = [
      "https://www.transparentpng.com/thumb/-iphone-x/7vQ8aI-iphone-pictures-transparent-png-pictures-free-icons.png",
      "https://static.vecteezy.com/system/resources/previews/012/981/082/original/wireless-headphones-side-view-white-icon-on-a-transparent-background-3d-rendering-png.png",
      "https://assets.stickpng.com/images/580b57fbd9996e24bc43bfbc.png",
      "https://assets.stickpng.com/images/5f49272168ecc70004ae707f.png",
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Yours Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: const Text(
                "See all",
                style: TextStyle(color: GlobalVariables.secondaryColor),
              ),
            ),
          ],
        ),
        // display orders
        Container(
          height: 170,
          padding: EdgeInsets.only(left: 10, right: 0, top: 20),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tempData.length,
              itemBuilder: ((context, index) {
                return Product(image: tempData[index]);
              })),
        )
      ],
    );
  }
}
