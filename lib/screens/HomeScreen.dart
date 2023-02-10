import 'package:flip/components/Home/AddressBar.dart';
import 'package:flip/components/Home/CarouselImage.dart';
import 'package:flip/components/Home/DealOfDay.dart';
import 'package:flip/components/Home/TopCategories.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/providers/user.dart';
import 'package:flip/screens/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
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
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBar(),
            SizedBox(
              height: 15,
            ),
            TopCategoies(),
            SizedBox(
              height: 15,
            ),
            CarouselImages(),
            SizedBox(
              height: 15,
            ),
            DealOfDay()
          ],
        ),
      ),
    );
  }
}
