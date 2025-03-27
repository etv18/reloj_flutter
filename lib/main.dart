import 'package:flutter/material.dart';

import 'package:reloj_proyecto/app.dart';

import 'package:reloj_proyecto/models/repository/time_info.dart';

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
