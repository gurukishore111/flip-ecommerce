import 'package:flip/components/Common/BotttomNav.dart';
import 'package:flip/models/Product.dart';
import 'package:flip/screens/AddProductScreen.dart';
import 'package:flip/screens/AddressScreen.dart';
import 'package:flip/screens/AuthScreen.dart';
import 'package:flip/screens/CategoryDeals.dart';
import 'package:flip/screens/HomeScreen.dart';
import 'package:flip/screens/NotFound.dart';
import 'package:flip/screens/ProductDetailsScreen.dart';
import 'package:flip/screens/SearchScreen.dart';
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
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const NotFound(),
      );
  }
}
