import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:reloj_proyecto/models/route_paths.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<String> _routes = [
    '/',
    '/${RoutePaths.stopWatch}',
    '/${RoutePaths.multiClock}',
    '/${RoutePaths.timer}',
  ];

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      items: <Widget>[
        Icon(Icons.watch_later, size: 40),
        Icon(Icons.watch_rounded, size: 40),
        Icon(FontAwesomeIcons.globe),
        Icon(Icons.timer, size: 40),
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
        context.go(_routes[_page]);
      },
      letIndexChange: (index) => true,
    );
  }
}
