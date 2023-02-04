import 'package:flip/constants/global_variables.dart';
import 'package:flip/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 20,
            color: GlobalVariables.iconColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "Delivery to ${user.name} - ${user.address == '' ? '\u{26A0} Update the address' : user.address}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 5, top: 2),
              child: Icon(
                Icons.arrow_drop_down_outlined,
                color: GlobalVariables.iconColor,
              ))
        ],
      ),
    );
  }
}
