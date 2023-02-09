import 'package:flip/constants/global_variables.dart';
import 'package:flip/screens/CategoryDeals.dart';
import 'package:flutter/material.dart';

class TopCategoies extends StatelessWidget {
  const TopCategoies({super.key});

  void navigateToCategory(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.builder(
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 78,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                navigateToCategory(
                    context, GlobalVariables.categoryImages[index]['title']!);
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: GlobalVariables.secondaryColor,
                          ),
                          child: Icon(
                            GlobalVariables.categoryImages[index]['icon']!,
                            size: 25,
                          ),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      GlobalVariables.categoryImages[index]['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
