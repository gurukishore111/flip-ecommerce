import 'package:flip/components/Common/BotttomNav.dart';
import 'package:flip/screens/AddProductScreen.dart';
import 'package:flip/screens/AuthScreen.dart';
import 'package:flip/screens/CategoryDeals.dart';
import 'package:flip/screens/HomeScreen.dart';
import 'package:flip/screens/NotFound.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case BottomNav.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomNav(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const NotFound(),
      );
  }
}
