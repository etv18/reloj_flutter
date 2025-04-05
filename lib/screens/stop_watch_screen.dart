import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reloj_proyecto/controllers/stopWatchCubit/stop_watch_cubit.dart';
import 'package:reloj_proyecto/controllers/stopWatchCubit/stop_watch_states.dart';
import 'package:reloj_proyecto/myWidgets/bottom_nav_bar.dart';
import 'package:reloj_proyecto/myWidgets/custom_app_bar.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  bool _isRunning = false;
  Color currentColor = Colors.red;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        currentColor = currentColor == Colors.red ? Colors.blue : Colors.red;
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
      appBar: CustomAppBar(title: 'StopWatch'),
      body: BlocBuilder<StopWatchCubit, StopWatchStates>(
        builder: (context, state) {
          if (state is StopWatchInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '00:00:00.0',
                    style: GoogleFonts.tourney(
                      fontSize: 70,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 2, 87, 110),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StopWatchCubit>().startStopWatch();
                    },
                    child: Text(
                      'Start',
                      style: GoogleFonts.tourney(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 2, 87, 110),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is StopWatchRunning) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.read<StopWatchCubit>().formatTimeString(),
                    style: GoogleFonts.tourney(
                      fontSize: 70,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 2, 87, 110),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isRunning = !_isRunning;
                          });
                          if (_isRunning) {
                            context.read<StopWatchCubit>().pauseStopWatch();
                          } else {
                            context.read<StopWatchCubit>().continueStopWatch();
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
                          setState(() {
                            _isRunning = false;
                          });
                          context.read<StopWatchCubit>().resetStopWatch();
                        },
                        icon: Icon(Icons.stop_circle, size: 69),
                        color: const Color.fromARGB(255, 243, 33, 33),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          } else if (state is StopWatchPaused) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.read<StopWatchCubit>().formatTimeString(),
                    style: GoogleFonts.tourney(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                      color: currentColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isRunning = !_isRunning;
                          });
                          if (_isRunning) {
                            context.read<StopWatchCubit>().pauseStopWatch();
                          } else {
                            context.read<StopWatchCubit>().continueStopWatch();
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
                          setState(() {
                            _isRunning = false;
                          });
                          context.read<StopWatchCubit>().resetStopWatch();
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
              child: Text(
                'Ha ocurrido un error',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        indexIcon: 1,
      ),
    );
  }
}
