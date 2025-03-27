import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:reloj_proyecto/myWidgets/bottom_nav_bar.dart';
import 'package:reloj_proyecto/myWidgets/custom_app_bar.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int sec = 0;
  int _min = 0;
  int _hour = 0;
  int time = 10;
  late int initialTime;

  late Timer _timer;
  late DateTime targetTime;
  Duration remainingTime = Duration.zero;

  /*void startTimer() {
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
  }*/

  void startTimer() {
    targetTime = DateTime.now().add(Duration(
      hours: _hour,
      minutes: _min,
      seconds: sec + 1,
    ));

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime = targetTime.difference(DateTime.now());
        if (remainingTime.isNegative) {
          remainingTime = Duration.zero;
          timer.cancel();
        }
      });
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   //_timer.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Timer'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${remainingTime.inHours.toString().padLeft(2, '0')}:'
              '${(remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:'
              '${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                startTimer();
              },
              icon: Icon(Icons.access_alarm),
              color: Colors.red,
              iconSize: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberPicker(
                  value: _hour,
                  minValue: 0,
                  maxValue: 24,
                  itemHeight: 80,
                  onChanged: (value) => setState(() => _hour = value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 133, 130, 130),
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Color.fromARGB(255, 53, 50, 50),
                    fontSize: 38.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                NumberPicker(
                  value: _min,
                  minValue: 0,
                  maxValue: 60,
                  itemHeight: 80,
                  onChanged: (value) => setState(() => _min = value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 133, 130, 130),
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Color.fromARGB(255, 53, 50, 50),
                    fontSize: 38.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                NumberPicker(
                  value: sec,
                  minValue: 0,
                  maxValue: 60,
                  itemHeight: 80,
                  onChanged: (value) => setState(() => sec = value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 133, 130, 130),
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Color.fromARGB(255, 53, 50, 50),
                    fontSize: 38.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
