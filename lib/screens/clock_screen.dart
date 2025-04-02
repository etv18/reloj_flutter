import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reloj_proyecto/controllers/clockCubit/clock_cubit.dart';
import 'package:reloj_proyecto/controllers/clockCubit/clock_state.dart';
import 'package:reloj_proyecto/myWidgets/bottom_nav_bar.dart';
import 'package:reloj_proyecto/myWidgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({
    super.key,
  });

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  bool is_12HourFormat = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      is_12HourFormat = prefs.getBool('is_12HourFormat') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Clock Srceen',
      ),
      body: Center(
        child: BlocBuilder<ClockCubit, DateTime>(
          builder: (context, state) {
            if (state is ClockInitial) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: AnimatedToggleSwitch<bool>.dual(
                      current: is_12HourFormat,
                      first: false,
                      second: true,
                      spacing: 50.0,
                      style: const ToggleStyle(
                        borderColor: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1.5),
                          ),
                        ],
                      ),
                      borderWidth: 5.0,
                      height: 55,
                      onChanged: (b) => setState(() {
                        is_12HourFormat = b;
                      }),
                      styleBuilder: (b) => ToggleStyle(
                          indicatorColor: b
                              ? const Color.fromARGB(255, 99, 129, 218)
                              : const Color.fromARGB(255, 18, 118, 18)),
                      iconBuilder: (value) => value
                          ? const Icon(Icons.twelve_mp_sharp)
                          : const Icon(Icons.twenty_four_mp),
                      textBuilder: (value) => value
                          ? const Center(child: Text('Format 24h'))
                          : const Center(child: Text('Format 12h')),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    context
                        .read<ClockCubit>()
                        .formatTime(state.currentTime, is_12HourFormat),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            } else {
              return const Center(child: Text("Error loading clock"));
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
