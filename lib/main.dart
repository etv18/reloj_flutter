import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/app.dart';
import 'package:reloj_proyecto/controllers/clockCubit/clock_cubit.dart';
import 'package:reloj_proyecto/controllers/multipleClocksCubit/multi_clocks_cubit.dart';
import 'package:reloj_proyecto/models/repository/time_info.dart';
import 'package:reloj_proyecto/screens/multi_clocks_screen.dart';
import 'package:reloj_proyecto/screens/stop_watch_screen.dart';
import 'package:reloj_proyecto/screens/timer_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    ),
  );

  TimeInfo timeinfo = TimeInfo();
  timeinfo.fetchTimes();
}
