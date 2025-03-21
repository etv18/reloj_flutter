import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MultiClockScreen extends StatefulWidget {
  const MultiClockScreen({super.key});

  @override
  _MultiClockScreenState createState() => _MultiClockScreenState();
}

class _MultiClockScreenState extends State<MultiClockScreen> {
  Map<String, DateTime> cityTimes = {};
  Timer? timer;

  final List<String> cities = [
    'America/New_York',
    'Australia/Sydney',
    'Europe/Madrid',
    'Europe/Paris'
  ];

  @override
  void initState() {
    super.initState();
    fetchTimes(); // Obtener la hora inicial

    // Iniciar un temporizador para actualizar cada segundo
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        cityTimes.updateAll((key, value) => value.add(Duration(seconds: 1)));
      });
    });
  }

  Future<void> fetchTimes() async {
    try {
      for (String city in cities) {
        final res = await http.get(Uri.parse(
            'https://timeapi.io/api/Time/current/zone?timeZone=$city'));

        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          setState(() {
            cityTimes[city] = DateTime.parse(data['dateTime']);
          });
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}:"
        "${time.second.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reloj Mundial")),
      body: ListView(
        children: cities.map((city) {
          return ListTile(
            title: Text(city.replaceAll('_', ' '),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text(cityTimes.containsKey(city)
                ? _formatTime(cityTimes[city]!)
                : "Cargando..."),
          );
        }).toList(),
      ),
    );
  }
}
