import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:reloj_proyecto/models/multi_clocks_model.dart';

class TimeInfo {
  List<MultiClocksModel> multiClocksList = [];
  final List<String> cities = [
    'America/New_York',
    'Australia/Sydney',
    'Europe/Madrid',
    'Europe/Paris',
  ];

  Future<List<MultiClocksModel>> fetchTimes() async {
    try {
      int c = 0;
      for (String city in cities) {
        final res = await http.get(Uri.parse(
            'https://timeapi.io/api/Time/current/zone?timeZone=$city'));

        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          MultiClocksModel multiClockItem = MultiClocksModel(
            cityTime: DateTime.parse(data['dateTime']),
            cityName: city.replaceAll('_', ' '),
          );
          multiClocksList.add(multiClockItem);
        }

        print(
            'city info: ${multiClocksList[c].cityName} : ${multiClocksList[c].cityTime}');
        c++;
      }
    } catch (e) {
      print('Error: $e');
    }

    return multiClocksList;
  }
}
