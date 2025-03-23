import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      items: <Widget>[
        Icon(Icons.shopping_bag, size: 40),
        Icon(Icons.list, size: 40),
        Icon(Icons.compare_arrows, size: 40),
        Icon(Icons.call_split, size: 40),
        Icon(Icons.perm_identity, size: 40),
      ],
      color: Color.fromARGB(255, 239, 234, 234),
      buttonBackgroundColor: Color(0XFFB0B0B0),
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
      letIndexChange: (index) => true,
    );
  }
}
