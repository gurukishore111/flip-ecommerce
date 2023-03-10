import 'package:flutter/material.dart';

String uri = 'http://0.0.0.0:8000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 22, 22, 22),
      Color.fromARGB(255, 18, 23, 23),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Color(0x00303030);
  static var iconColor = Colors.grey.shade700;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromRGBO(255, 153, 0, 1);
  static var unselectedNavBarColor = Colors.grey.shade700;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, dynamic>> categoryImages = [
    {'title': 'Mobiles', "icon": Icons.phone_iphone_rounded},
    {'title': 'Essentials', "icon": Icons.medical_information},
    {'title': 'Appliances', "icon": Icons.microwave_rounded},
    {'title': 'Books', "icon": Icons.library_books},
    {'title': 'Fashion', "icon": Icons.diamond_rounded},
  ];
}
