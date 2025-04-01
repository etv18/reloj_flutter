import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/controllers/stopWatchCubit/stop_watch_states.dart';

class StopWatchCubit extends Cubit<StopWatchStates> {
  StopWatchCubit() : super(const StopWatchInitial());

  ///elapseTime variable will take the exact value of stopwatch.elapse
  ///due to that property returns an Duration object
  Duration elapseTime = Duration.zero;
  Stopwatch stopWatch = Stopwatch();
  late Timer _timer;

  void startStopWatch() {
    stopWatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      elapseTime = stopWatch.elapsed;
      emit(StopWatchRunning(elapseTime));
    });
  }

  void pauseStopWatch() {
    stopWatch.stop();
    _timer.cancel();
    emit(StopWatchPaused(elapseTime));
  }

  void continueStopWatch() {
    stopWatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      elapseTime = stopWatch.elapsed;
      emit(StopWatchRunning(elapseTime));
    });
  }

  void resetStopWatch() {
    emit(StopWatchInitial());
    stopWatch.reset();
    _timer.cancel();
    elapseTime = Duration.zero;
  }

  String formatTimeString() {
    return '${elapseTime.inHours.toString().padLeft(2, '0')}:'
        '${(elapseTime.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(elapseTime.inSeconds % 60).toString().padLeft(2, '0')}.'
        '${((elapseTime.inMilliseconds % 1000) ~/ 100).toString()}';
  }
}
