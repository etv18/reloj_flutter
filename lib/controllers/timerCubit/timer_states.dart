import 'package:equatable/equatable.dart';

abstract class TimerStates extends Equatable {
  final Duration remainingTime;

  const TimerStates(this.remainingTime);

  @override
  List<Object> get props => [remainingTime];
}

class TimerInitial extends TimerStates {
  TimerInitial() : super(Duration.zero);
}

class TimerRunning extends TimerStates {
  const TimerRunning(Duration remainingTime) : super(remainingTime);
}

class TimerPaused extends TimerStates {
  const TimerPaused(Duration remainingTime) : super(remainingTime);
}

class TimerEnded extends TimerStates {
  const TimerEnded() : super(Duration.zero);
}
