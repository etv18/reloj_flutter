import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
  int _sec = 0;
  int _min = 0;
  int _hour = 0;
  bool _isRunning = false;
  Color currentColor = const Color.fromARGB(255, 66, 6, 220);
  Timer? _timer;

  void resetValues() {
    _sec = 0;
    _min = 0;
    _hour = 0;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        currentColor = currentColor == Color.fromARGB(255, 66, 6, 220)
            ? const Color.fromARGB(255, 24, 121, 42)
            : Color.fromARGB(255, 66, 6, 220);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
                    style: GoogleFonts.tourney(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 2, 87, 110),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<TimerCubit>()
                              .startTimer(_hour, _min, _sec);
                          resetValues();
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
                        textStyle: GoogleFonts.tourney(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 133, 130, 130),
                        ),
                        selectedTextStyle: GoogleFonts.tourney(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 2, 87, 110),
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
                        textStyle: GoogleFonts.tourney(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 133, 130, 130),
                        ),
                        selectedTextStyle: GoogleFonts.tourney(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 2, 87, 110),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      NumberPicker(
                        value: _sec,
                        minValue: 0,
                        maxValue: 60,
                        itemHeight: 80,
                        onChanged: (value) => setState(() => _sec = value),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black26),
                        ),
                        textStyle: GoogleFonts.tourney(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 133, 130, 130),
                        ),
                        selectedTextStyle: GoogleFonts.tourney(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 2, 87, 110),
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
                    style: GoogleFonts.tourney(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 2, 87, 110),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isRunning = !_isRunning;
                          });
                          if (_isRunning) {
                            context.read<TimerCubit>().pauseTimer();
                          }
                        },
                        icon: Icon(
                            _isRunning ? Icons.pause_circle : Icons.play_circle,
                            size: 69),
                        color: Colors.blue,
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<TimerCubit>().resetTimer();
                          setState(() {
                            _isRunning = false;
                          });
                          resetValues();
                        },
                        icon: Icon(Icons.stop_circle, size: 69),
                        color: const Color.fromARGB(255, 243, 33, 33),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is TimerPaused) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context
                        .read<TimerCubit>()
                        .getTimeStringFormated(state.remainingTime),
                    style: GoogleFonts.tourney(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                      color: currentColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isRunning = !_isRunning;
                          });
                          if (_isRunning) {
                            context.read<TimerCubit>().pauseTimer();
                          } else {
                            context.read<TimerCubit>().continueTimer();
                          }
                        },
                        icon: Icon(
                            _isRunning ? Icons.pause_circle : Icons.play_circle,
                            size: 69),
                        color: Colors.blue,
                        iconSize: 30.0,
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<TimerCubit>().resetTimer();
                          setState(() {
                            _isRunning = false;
                          });
                          resetValues();
                        },
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
