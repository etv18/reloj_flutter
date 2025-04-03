import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/controllers/clockCubit/clock_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockCubit extends Cubit<ClockStates> {
  Timer? _timer;
  bool is_12HourFormat = false;
  String formattedHours = "";
  int hour = 0;
  String period = "";
  late SharedPreferences prefs;

  ///Clock is inicialized calling an initial state
  ///from the parent class DateTime in the super
  ///constructor as it's been shown below
  ClockCubit() : super(ClockInitial(DateTime.now(), false)) {
    initPrefs();
    startClock();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    is_12HourFormat = prefs.getBool('is_12HourFormat') ?? false;
  }

  void setPrefs() async {
    prefs.setBool('is_12HourFormat', is_12HourFormat);
    print("==============>is_12HourFormat [CLOCK CUBIT]: $is_12HourFormat");
  }

  void startClock() {
    ///emiting the initial state
    emit(ClockInitial(DateTime.now(), is_12HourFormat));

    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      ///every second the timer will emit the current Time
      emit(ClockInitial(DateTime.now(), is_12HourFormat));
    });
  }

  String formatTime(DateTime time, bool hourFormat) {
    is_12HourFormat = hourFormat;
    setPrefs();

    ///This basically will add 0 everytime a hour, min or sec reach a 0 value
    ///instead of presenting nothing it will add 1 or 2 zeros
    if (is_12HourFormat) {
      hour = time.hour > 12 ? time.hour - 12 : time.hour;
      period = time.hour >= 12 ? "PM" : "AM";
      formattedHours = "${hour.toString().padLeft(2, '0')}:"
          "${time.minute.toString().padLeft(2, '0')}:"
          "${time.second.toString().padLeft(2, '0')} $period";
    } else {
      formattedHours = "${time.hour.toString().padLeft(2, '0')}:"
          "${time.minute.toString().padLeft(2, '0')}:"
          "${time.second.toString().padLeft(2, '0')}";
    }

    return formattedHours;
  }

  @override
  Future<void> close() {
    ///This function will stop the timer when the cubit is closed
    _timer?.cancel();
    return super.close();
  }
}
