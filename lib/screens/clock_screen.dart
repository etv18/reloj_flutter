import 'package:flutter/material.dart';
import 'package:reloj_proyecto/myWidgets/bottom_nav_bar.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch Screen',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
