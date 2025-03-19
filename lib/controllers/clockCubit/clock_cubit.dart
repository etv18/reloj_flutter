import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClockCubit extends Cubit<DateTime> {
  Timer? _timer;

  ///Clock is inicialized calling an initial state
  ///from the parent class DateTime in the super
  ///constructor as it's been shown below
  ClockCubit() : super(DateTime.now());

  void startClock() {
    ///emiting the initial state
    emit(DateTime.now());

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      ///every second the timer will emit the current Time
      emit(DateTime.now());
    });
  }

  String formatTime(DateTime time) {
    ///This basically will add 0 everytime a hour, min or sec reach a 0 value
    ///instead of presenting nothing it will add 1 or 2 zeros
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}:"
        "${time.second.toString().padLeft(2, '0')}";
  }

  @override
  Future<void> close() {
    ///This function will stop the timer when the cubit is closed
    _timer?.cancel();
    return super.close();
  }
}
