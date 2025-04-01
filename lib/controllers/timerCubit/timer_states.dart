import 'package:equatable/equatable.dart';

abstract class TimerStates extends Equatable {
  final Duration remainingTime;

  const TimerStates(this.remainingTime);

  @override
  List<Object> get props => [remainingTime];
}

class TimerInitial extends TimerStates {
  const TimerInitial() : super(Duration.zero);
}

class TimerRunning extends TimerStates {
  const TimerRunning(super.remainingTime);
}

class TimerPaused extends TimerStates {
  const TimerPaused(super.remainingTime);
}

class TimerEnded extends TimerStates {
  const TimerEnded() : super(Duration.zero);
}
