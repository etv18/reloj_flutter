import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/models/multi_clocks_model.dart';
import 'package:reloj_proyecto/models/repository/time_info.dart';

class MultiClocksCubit extends Cubit<List<MultiClocksModel>> {
  final TimeInfo _repository = TimeInfo();
  Timer? _timer;

  MultiClocksCubit() : super([]) {
    startClock();
  }

  Future<void> startClock() async {
    final citiesTimeInfo = await _repository.fetchTimes();
    emit(citiesTimeInfo);

    //here the timer will be initialized
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      emit(state.map((city) {
        return MultiClocksModel(
          cityTime: city.cityTime.add(Duration(seconds: 1)),
          cityName: city.cityName,
        );
      }).toList());
    });
  }

  ///this function will stop the timer once the screen is closed
  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
