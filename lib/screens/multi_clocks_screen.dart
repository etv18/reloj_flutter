import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reloj_proyecto/controllers/multipleClocksCubit/multi_clocks_cubit.dart';
import 'package:reloj_proyecto/models/multi_clocks_model.dart';
import 'package:reloj_proyecto/myWidgets/bottom_nav_bar.dart';
import 'package:reloj_proyecto/myWidgets/custom_app_bar.dart';

class MultiClocksScreen extends StatefulWidget {
  const MultiClocksScreen({
    super.key,
  });

  @override
  State<MultiClocksScreen> createState() => _MultiClocksScreenState();
}

class _MultiClocksScreenState extends State<MultiClocksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MultiClocksCubit>();
    context.read<MultiClocksCubit>().initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Global Time'),
      body: BlocBuilder<MultiClocksCubit, List<MultiClocksModel>>(
          builder: (context, cityTimesInfo) {
        if (cityTimesInfo.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (cityTimesInfo.isNotEmpty) {
          return ListView.builder(
              itemCount: cityTimesInfo.length,
              itemBuilder: (context, index) {
                final city = cityTimesInfo[index];
                return ListTile(
                  title: Text(city.cityName,
                      style: GoogleFonts.tourney(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 2, 87, 110),
                      )),
                  subtitle: Text(
                    context.read<MultiClocksCubit>().formatTime(city.cityTime),
                    style: GoogleFonts.tourney(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 2, 87, 110),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: Text("Ha ocurrido un error!"),
          );
        }
      }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
