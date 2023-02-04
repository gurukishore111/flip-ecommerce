import 'package:badges/badges.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

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
    const Center(child: Text('Profile')),
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
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor.shade600,
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
              child: const Icon(Icons.home_outlined),
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
              child: const Icon(Icons.person_outline),
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
                  badgeContent: const Text(
                    '2',
                    style: TextStyle(
                      color: GlobalVariables.secondaryColor,
                      fontSize: 14,
                    ),
                  ),
                  badgeColor: Colors.grey.shade800,
                  child: const Icon(Icons.shopping_cart_outlined)),
            ),
          )
        ],
      ),
    );
  }
}
