abstract class ClockStates extends DateTime {
  final DateTime currentTime;
  bool hourFormat;

  ClockStates(this.currentTime, this.hourFormat)
      : super(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          currentTime.hour,
          currentTime.minute,
          currentTime.second,
          currentTime.millisecond,
          currentTime.microsecond,
        );
}

class ClockInitial extends ClockStates {
  ClockInitial(super.currentTime, super.hourFormat);
}
