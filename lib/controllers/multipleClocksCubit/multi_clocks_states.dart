import 'package:reloj_proyecto/models/multi_clocks_model.dart';

abstract class MultiClocksStates {}

class MultiClocksLoading extends MultiClocksStates {}

class MultiClocksLoaded extends MultiClocksStates {
  final List<MultiClocksModel> citiesTimeInfo;
  MultiClocksLoaded({
    required this.citiesTimeInfo,
  });
}
