import 'package:equatable/equatable.dart';

abstract class StopWatchStates extends Equatable {
  final Duration time;

  const StopWatchStates(this.time);
  @override
  List<Object> get props => [time];
}

class StopWatchInitial extends StopWatchStates {
  const StopWatchInitial() : super(Duration.zero);
}

class StopWatchRunning extends StopWatchStates {
  const StopWatchRunning(super.time);
}

class StopWatchPaused extends StopWatchStates {
  const StopWatchPaused(super.time);
}

class StopWatchReset extends StopWatchStates {
  const StopWatchReset(super.time);
}
