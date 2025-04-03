import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/models/multi_clocks_model.dart';
import 'package:reloj_proyecto/models/repository/time_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiClocksCubit extends Cubit<List<MultiClocksModel>> {
  final TimeInfo _repository = TimeInfo();
  Timer? _timer;
  bool is_12HourFormat = false;
  String formattedHours = "";
  int hour = 0;
  String period = "";
  late SharedPreferences prefs;

  MultiClocksCubit() : super([]) {
    initPrefs();
    startClock();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    is_12HourFormat = prefs.getBool('is_12HourFormat') ?? false;
  }

  Future<void> startClock() async {
    final citiesTimeInfo = await _repository.fetchTimes();
    emit(citiesTimeInfo);

    //here the timer will be initialized
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      emit(state.map((city) {
        return MultiClocksModel(
          cityTime: city.cityTime.add(Duration(milliseconds: 90)),
          cityName: city.cityName,
        );
      }).toList());
    });
  }

  String formatTime(DateTime time) {
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

  ///this function will stop the timer once the screen is closed
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
