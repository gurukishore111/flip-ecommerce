import 'package:flip/constants/global_variables.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.black38),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Text("Deal of the Day"),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black38),
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Image.network(
                  'https://res.cloudinary.com/gk1/image/upload/v1675521345/laptop_quujhf.png',
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Lenovo',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Lenovo Ideapad 1i, 14.0" Laptop, Intel Pentium N5030, 4GB RAM, 128GB eMMC Storage, Cloud Grey, Windows 11 in S Mode, 82V6001DUS',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$158.94',
                      style: TextStyle(
                        color: GlobalVariables.secondaryColor,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://res.cloudinary.com/gk1/image/upload/v1675521345/laptop_quujhf.png',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://res.cloudinary.com/gk1/image/upload/v1675521345/laptop_quujhf.png',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://res.cloudinary.com/gk1/image/upload/v1675521345/laptop_quujhf.png',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://res.cloudinary.com/gk1/image/upload/v1675521345/laptop_quujhf.png',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: const Text(
                  "See all deals",
                  style: TextStyle(
                    color: GlobalVariables.secondaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
