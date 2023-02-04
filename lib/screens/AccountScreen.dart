import 'package:flip/components/Account/GreetingUserName.dart';
import 'package:flip/components/Account/Options.dart';
import 'package:flip/components/Account/Orders.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                    'Flip',
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
                  Padding(
                    padding: EdgeInsets.only(right: 1),
                    child: Icon(
                      Icons.search,
                      size: 28,
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
      body: Column(children: const [
        GreetingUserName(),
        SizedBox(
          height: 20,
        ),
        Option(),
        SizedBox(
          height: 20,
        ),
        Orders(),
      ]),
    );
  }
}
