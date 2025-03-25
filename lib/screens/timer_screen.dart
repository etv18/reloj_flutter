import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reloj_proyecto/myWidgets/bottom_nav_bar.dart';
import 'package:reloj_proyecto/myWidgets/custom_app_bar.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int time = 10;
  late int initialTime = time;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time == 0) {
        setState(() {
          time = initialTime;
          timer.cancel();
        });
      } else {
        setState(() {
          time--;
          print('=====> TIME: ${time.toString()}');
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Timer'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '00:00:${time.toString()}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                startTimer();
              },
              icon: Icon(Icons.start_rounded),
              color: Colors.blueAccent,
              iconSize: 30.0,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
