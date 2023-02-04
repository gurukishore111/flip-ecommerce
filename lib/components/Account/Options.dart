import 'package:flip/components/Account/OptionButtons.dart';
import 'package:flutter/material.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            OptionButton(text: 'Your Orders', onTap: () => print('object')),
            OptionButton(text: 'Turn Seller', onTap: () => print('object'))
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            OptionButton(text: 'Log out', onTap: () => print('object')),
            OptionButton(text: 'Your Cart', onTap: () => print('object'))
          ],
        )
      ],
    );
  }
}
