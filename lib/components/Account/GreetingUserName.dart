import 'package:flip/constants/global_variables.dart';
import 'package:flip/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class GreetingUserName extends StatelessWidget {
  const GreetingUserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 15, top: 5, right: 5, bottom: 15),
      child: Row(
        children: [
          const Text(
            'Hello \u{1F44B},',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            user.name,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
