import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Emmanuel Tavarez ',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
