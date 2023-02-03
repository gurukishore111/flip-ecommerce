import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeHolder;

  const CustomTextField({required this.controller, required this.placeHolder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: placeHolder,
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey.shade500,
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey.shade500,
          ))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $placeHolder';
        }
        return null;
      },
    );
  }
}
