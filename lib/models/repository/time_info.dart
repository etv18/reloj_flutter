import 'package:http/http.dart' as http;
import 'dart:convert';

class TimeInfo {
  final String apiUrl =
      'https://timeapi.io/api/Time/current/zone?timeZone=America/Santo_Domingo';

  Future<DateTime> fetchTime() async {
    final res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return DateTime.parse(data['dateTime']);
    } else {
      throw Exception();
    }
  }
}
