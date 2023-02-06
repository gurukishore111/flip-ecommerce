import 'package:badges/badges.dart';
import 'package:flip/constants/global_variables.dart';
import 'package:flip/screens/AccountScreen.dart';
import 'package:flip/screens/AdminScreen.dart';
import 'package:flip/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class AdminBottomNav extends StatefulWidget {
  static const String routeName = '/actual-home';
  const AdminBottomNav({super.key});

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _page = 0;
  double _bottomNavWidth = 42;
  double _bottomNavBorderWidth = 3;

  List<Widget> pages = [
    const AdminScreen(),
    const Center(child: Text("Analytics Screen")),
    const Center(child: Text("Cart Screen")),
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
              child: const Icon(Icons.post_add_rounded),
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
              child: const Icon(Icons.analytics_rounded),
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
              child: const Icon(Icons.all_inbox_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
