import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const OptionButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 0.00, color: Colors.transparent),
          borderRadius: BorderRadius.circular(50),
          color: Colors.black12,
        ),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black12.withOpacity(0.03),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
