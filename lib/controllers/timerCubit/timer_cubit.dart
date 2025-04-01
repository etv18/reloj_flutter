import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/controllers/timerCubit/timer_states.dart';

class TimerCubit extends Cubit<TimerStates> {
  String timeString = '';
  late Timer _timer;
  late DateTime targetTime;
  Duration remainingTime = Duration.zero;

  TimerCubit() : super(TimerInitial());

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  void startTimer(int hour, int min, int sec) {
    ///This will take the exact moment when the time in hours, mins and secs
    ///which was entered is finished
    if (hour == 0 && min == 0 && sec == 0) {
      emit(TimerInitial());
      return;
    }
    targetTime = DateTime.now().add(Duration(
      hours: hour,
      minutes: min,
      seconds: sec + 2,
    ));

    _timer = Timer.periodic(
      Duration(milliseconds: 100),
      (Timer timer) {
        remainingTime = targetTime.difference(DateTime.now());
        print('==========**> $remainingTime');

        if (remainingTime.isNegative) {
          emit(TimerInitial());
          remainingTime = Duration.zero;
          timer.cancel();
          return;
        }
        emit(TimerRunning(remainingTime));
      },
    );
  }

  void pauseTimer() {
    emit(TimerPaused(remainingTime));
    _timer.cancel();
  }

  void continueTimer() {
    targetTime = DateTime.now().add(remainingTime);

    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      remainingTime = targetTime.difference(DateTime.now());

      if (remainingTime.isNegative) {
        emit(TimerInitial());
        remainingTime = Duration.zero;
        timer.cancel();
        return;
      }
      emit(TimerRunning(remainingTime));
    });
  }

  void resetTimer() {
    emit(TimerInitial());
    _timer.cancel();
  }

  String getTimeStringFormated(Duration remainingTime) {
    return '${remainingTime.inHours.toString().padLeft(2, '0')}:'
        '${(remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}
