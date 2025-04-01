import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
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
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<StopWatchCubit>().startStopWatch();
                    },
                    child: const Text('Iniciar'),
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
                    style: Theme.of(context).textTheme.headlineLarge,
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
          } else if (state is StopWatchPaused) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.read<StopWatchCubit>().formatTimeString(),
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 214, 8, 8),
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
