import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:reloj_proyecto/controllers/timerCubit/timer_cubit.dart';
import 'package:reloj_proyecto/controllers/timerCubit/timer_states.dart';
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Timer'),
      body: BlocBuilder<TimerCubit, TimerStates>(
        builder: (context, state) {
          if (state is TimerInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${state.remainingTime.inHours.toString().padLeft(2, '0')}:'
                    '${(state.remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:'
                    '${(state.remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<TimerCubit>()
                              .startTimer(_hour, _min, sec);
                        },
                        icon: Icon(Icons.play_circle, size: 69),
                        color: Colors.blue,
                        iconSize: 30.0,
                      ),
                    ],
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
            );
          } else if (state is TimerRunning) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context
                        .read<TimerCubit>()
                        .getTimeStringFormated(state.remainingTime),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.play_circle, size: 69),
                        color: Colors.blue,
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.stop_circle, size: 69),
                        color: const Color.fromARGB(255, 243, 33, 33),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Ha ocurrido un error'),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
