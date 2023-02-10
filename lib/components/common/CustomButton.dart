import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? color;

  const CustomButton({required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
            color: color == null ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        primary: color,
      ),
    );
  }
}
