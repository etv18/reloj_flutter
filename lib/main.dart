import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/controllers/clockCubit/clock_cubit.dart';
import 'package:reloj_proyecto/models/repository/time_info.dart';
import 'package:reloj_proyecto/screens/clock_screen.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ClockCubit(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClockScreen(),
    ),
  ));

  TimeInfo timeinfo = TimeInfo();
  timeinfo.fetchTimes();
}
