import 'package:badges/badges.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/providers/user.dart';
import 'package:flip/screens/AccountScreen.dart';
import 'package:flip/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 0;
  double _bottomNavWidth = 42;
  double _bottomNavBorderWidth = 3;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(child: Text('Cart')),
  ];

  void updatePage(int page) {
    print('page $page');
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        selectedFontSize: 1.0,
        iconSize: 30,
        backgroundColor: Colors.black26,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: _bottomNavWidth,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  width: _bottomNavBorderWidth,
                  color: _page == 0
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                ),
              )),
              child: const Icon(Icons.home_rounded),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: _bottomNavWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: _bottomNavBorderWidth,
                color: _page == 1
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
              ))),
              child: const Icon(Icons.person_rounded),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: _bottomNavWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                width: _bottomNavBorderWidth,
                color: _page == 2
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
              ))),
              child: Badge(
                  elevation: 0,
                  badgeContent: Text(
                    userCartLen.toString(),
                    style: const TextStyle(
                      color: GlobalVariables.secondaryColor,
                      fontSize: 14,
                    ),
                  ),
                  badgeColor: Colors.grey.shade800,
                  child: const Icon(Icons.shopping_cart_rounded)),
            ),
          )
        ],
      ),
    );
  }
}
