import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:reloj_proyecto/models/route_paths.dart';

class BottomNavBar extends StatefulWidget {
  int? indexIcon;
  BottomNavBar({super.key, this.indexIcon});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int? indexPage;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    indexPage = widget.indexIcon;
  }

  final List<String> _routes = [
    '/', //Clock Sreen is root view
    '/${RoutePaths.stopWatch}',
    '/${RoutePaths.multiClock}',
    '/${RoutePaths.timer}',
  ];

  @override
  Widget build(BuildContext context) {
    ///It gives me the current route path Im in without parameters
    ///when I click on the icons and go router takes me to the screen
    ///I want to see.
    ///ex: '/clock-screen', '/stop-watch-screen'
    int getSelectedIndex(BuildContext context) {
      String currentRoute =
          GoRouter.of(context).routeInformationProvider.value.uri.toString();

      return _routes.indexOf(
          currentRoute); // looks for the path string in _routes List and returns it
    }

    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: getSelectedIndex(context),
      items: <Widget>[
        Icon(Icons.watch_later, size: 40),
        Icon(Icons.timer, size: 40),
        Icon(FontAwesomeIcons.globe),
        Icon(Icons.timer_10_select_outlined, size: 40),
      ],
      color: Color.fromARGB(255, 239, 234, 234),
      buttonBackgroundColor: Color(0XFFB0B0B0),
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: (index) {
        context.push(_routes[index]);
      },
      letIndexChange: (index) => true,
    );
  }
}
